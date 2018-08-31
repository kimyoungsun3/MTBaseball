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
// class HighScores()
//------------------------------------------------------------------------------
// Used with PHPHandler to provide Score submission / retrieval capabilities. 
//   requires mySQL database to perform correctly.
//==============================================================================
public class HighScores : MonoBehaviour
{	
	// GUI Rectangles
	private Rect rectLblName  = new Rect(  10, 240, 100,  20 );
	private Rect rectLblScore = new Rect(  10, 270, 100,  20 );
	private Rect rectFldName  = new Rect( 110, 240, 200,  20 );
	private Rect rectFldScore = new Rect( 110, 270, 200,  20 );
	private Rect rectButton   = new Rect( 110, 300, 200,  20 );
	private Rect rectGetDump  = new Rect( 320, 220, 200,  20 );
	private Rect rectLblDump  = new Rect( 320,  10, 200, 200 );
	
	// gui Form Variables
	private string formName = "";
	private string formScore = "";
	
	private string dump = "";
	
	// PHP Handler -- SET IN INSPECTOR	
	public PHPHandler php;
	
	//==========================================================================
	// void OnGUI()
	//--------------------------------------------------------------------------
	// Draws the form.
	//==========================================================================	
	void OnGUI()
	{
		GUI.Label( rectLblName, "Your Name:" );
		GUI.Label( rectLblScore, "Your Score:" );	
		
		formName = GUI.TextField ( rectFldName, formName );
		formScore = GUI.TextField ( rectFldScore, formScore );
		
		// Submit Score. Automatically gets score listings afterwards.
		if ( GUI.Button ( rectButton , "Submit Score" ) )
			SendScore();
			
		GUI.TextArea( rectLblDump, dump );
		
		// Request Score Listings
		if ( GUI.Button ( rectGetDump , "Get Scores" ) )
			GetScores( "" );
	}
	
	//==========================================================================
	// void SendScore()
	//--------------------------------------------------------------------------
	// Formats the WWWForm and submits score via PHPHandler request.
	//==========================================================================	
	void SendScore()
	{
		WWWForm form = new WWWForm();

		form.AddField( "score", formScore );
		form.AddField( "name", formName );
		
		// Submits form, action is PutScore, Callback is GetScores()
		php.Request( form, PHPHandler.RequestType.PutScore, GetScores );
		
		formName = "";
		formScore = "";
	}
	
	//==========================================================================
	// void ParseScores()
	//--------------------------------------------------------------------------
	// Callback Method. Called as a callback from SendScore, or called directly
	//   via a GUI button. Gets data, and sends data to ParseScore.
	//==========================================================================	
	void GetScores( string data )
	{
		php.Request( PHPHandler.RequestType.GetScores, ParseScores );	
	}

	//==========================================================================
	// void ParseScores()
	//--------------------------------------------------------------------------
	// Formats score listings received from request and stores them in dump.
	//==========================================================================	
	void ParseScores( string data )
	{
		// Entries are seperated with <br> in data. We replace those with \n
		dump = data.Replace( "<br>", "\n" );
	}
}