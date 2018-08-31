//==============================================================================
// PHPHandler Class Credits
//------------------------------------------------------------------------------
// Version: 2.0, 17/04/2009
// Author:  Nick Breslin (nickbreslin@gmail.com), Waddlefarm.org
// License: Free for commercial or personal use, modification, distribution
//==============================================================================

using UnityEngine;
using System.Collections;

//==============================================================================
// class PHPHandler()
//------------------------------------------------------------------------------
// Manages interfacing between Unity and a PHP Script
//==============================================================================
public class PHPHandler : MonoBehaviour
{
	public enum RequestType { Test, Email, PutScore, GetScores };
	public delegate void Callback( string data );
	public string baseUrl;
	public string hash;
	
	//==========================================================================
	// void Start()
	//--------------------------------------------------------------------------
	// Performs empty check and begins connection test.
	//==========================================================================
	void Start ()
	{	
		// Empty Check for Inspector values
		if( baseUrl == "" ) Debug.LogError( "BaseUrl cannot be null." );
		if( hash == "" ) Debug.LogError( "Hash cannot be null." );
		
		// Test Connection
		Request( RequestType.Test, TestConnection );
	}	

	//==========================================================================
	// void Request() -- Overloads
	//--------------------------------------------------------------------------
	// These are the overload methods for our primary Request() method. They
	//   allow for various ways to call the request, each passing the initial
	//   call to another method, until finally the primary method.
	//==========================================================================
	public void Request( RequestType action ) {
		Request( action, null ); }

	public void Request( WWWForm form, RequestType action ) {
		Request( form, action, null ); }
	
	
	public void Request( RequestType action, Callback callback ) {
		WWWForm form = new WWWForm();
		Request( form, action, callback ); 
	}
	
	public void Request2(RequestType _action, Callback _cb){
		WWWForm _form = new WWWForm();
		Request(_form, _action, _cb);
	}

	//==========================================================================
	// void Request()
	//--------------------------------------------------------------------------
	// Primary Request(). Attaches the action and the hash (security) into the
	//   WWWForm and calls the coroutine, Handle().
	//==========================================================================	
	public void Request( WWWForm form, RequestType action, Callback callback )
	{
		// Adds fields to form.
		form.AddField( "action", "" + action ); 
		form.AddField( "hash", hash );
		
		Debug.Log( "PHP Request: " + action );
		
		// Creates Coroutine, calls Handle and passes form, callback.
		StartCoroutine( Handle( new WWW( baseUrl, form ), callback ) );
	}
	
	public void Request2(WWWForm _form, RequestType _action, Callback _cb){
		_form.AddField("action", ""+_action);
		_form.AddField("hash", hash);
		Debug.Log( "PHP Request: " + _action);
		StartCoroutine(Handle(new WWW(baseUrl, _form), _cb));		
	}

	//==========================================================================
	// IEnumerator Handle()
	//--------------------------------------------------------------------------
	// Handle is called as a coroutine, as the length of time to receive a
	//   response from the PHP script is undetermined. A coroutine is needed so
	//   the application does not hang.
	// Executes a callback once the retrieval of data is complete.
	//==========================================================================	
	public IEnumerator Handle( WWW _www, Callback callback )
	{	
		// Yields until retrieval complete.
		yield return _www;
		
		if( _www.error == null ){
			Debug.Log( "PHP Handle: Successful." );
			
			// Is there a Callback with this Request?
	    	if( callback != null ){ 
				Debug.Log(_www.data);
	        	callback( _www.data ); // Executes Callback, passes in retrieved data
	        	callback = null; 
	      	} 
		}else{
			Debug.Log( "PHP Handle(error):" + _www.error );
		}
		
		// Clears data
		_www.Dispose();
	}

	//==========================================================================
	// void TestConnection()
	//--------------------------------------------------------------------------
	// Callback Method. Compares the retrieved data to a predetermined string.
	//  This is done www.error only catches an connection problems, not 404 page
	//  errors.
	//==========================================================================	
	public void TestConnection( string data )
	{
		if( data == "Test." )
			Debug.Log( "Connection Test Successful." );
	}

	//==========================================================================
	// void Print()
	//--------------------------------------------------------------------------
	// Callback Method. Used for Debugging purposes. This method is used as a 
	//   callback to print the retrieved data to the Debug log.
	//==========================================================================	
	public void Print( string data )
	{
		Debug.Log( data );
	}
}
