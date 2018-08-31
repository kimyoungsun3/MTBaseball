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
// class CommentForm()
//------------------------------------------------------------------------------
// Used with PHPHandler to provide E-Mail capabilities. CommentForm is the
//   front-end UI form.
//==============================================================================
public class CommentForm : MonoBehaviour
{
	// GUI Rectangles
	private Rect rectLblComment = new Rect(  10,  10, 100,  20 );
	private Rect rectLblName    = new Rect(  10, 120, 100,  20 );
	private Rect rectLblEmail   = new Rect(  10, 150, 100,  20 );
	private Rect rectFldMessage = new Rect( 110,  10, 200, 100 );
	private Rect rectFldName    = new Rect( 110, 120, 200,  20 );
	private Rect rectFldEmail   = new Rect( 110, 150, 200,  20 );
	private Rect rectButton     = new Rect( 110, 180, 200,  20 );
	
	// GUI Form Variables
	private string formMessage = "";
	private string formName = "";
	private string formEmail = "";
	
	// PHP Handler -- SET IN INSPECTOR
	public PHPHandler php;

	//==========================================================================
	// void OnGUI()
	//--------------------------------------------------------------------------
	// Draws the form.
	//==========================================================================
	void OnGUI()
	{
		// Draw Labels
		GUI.Label( rectLblComment, "Comment:" );
		GUI.Label( rectLblName, "Your Name:" );	
		GUI.Label( rectLblEmail, "Your E-Mail:" );	
		
		// Draw Fields
		formMessage = GUI.TextArea ( rectFldMessage, formMessage );
		formName = GUI.TextField ( rectFldName, formName );
		formEmail = GUI.TextField ( rectFldEmail, formEmail );
		
		// Submit Button
		if ( GUI.Button ( rectButton , "Send Message" ) )
			SendForm();
	}

	//==========================================================================
	// void SendForm()
	//--------------------------------------------------------------------------
	// Formats the WWWForm with the GUI Field values and sends it to PHPHandler.
	//==========================================================================
	void SendForm()
	{
		WWWForm form = new WWWForm();

		form.AddField( "message", formMessage );
		form.AddField( "name", formName );
		form.AddField( "email", formEmail );
		
		// Sends Form, Action is Email, no Callback
		php.Request( form, PHPHandler.RequestType.Email, php.Print );
		
		// Clears Form
		formMessage = "";
		formName = "";
		formEmail = "";
	}
}