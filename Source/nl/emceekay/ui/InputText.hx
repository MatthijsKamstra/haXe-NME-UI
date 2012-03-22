/**
* InputText.as
* Keith Peters
* version 0.9.10
* 
* Copyright (c) 2011 Keith Peters
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

package nl.emceekay.ui;

import flash.display.Sprite;
import flash.events.FocusEvent;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.display.Bitmap;
import flash.display.BitmapData;


class InputText extends Component
{
	
	public var maxChars(getMaxChars, setMaxChars):Int;
	public var password(getPassword, setPassword):Bool;
	public var restrict(getRestrict, setRestrict):String;
	public var text(getText, setText):String;
	public var textField(getTextField, null):TextField;
	
	var _back:Sprite;
	var _password:Bool;
	var _text:String;
	var _defaultText:String;
	var _tf:TextField;
	
	// skin-albe layers
	var _state:Bitmap;

	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this InputText.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param text The string containing the initial text of this component.
	 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
	 */
	public function new(?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float =  0, ?text:String = "", ?defaultHandler:Dynamic = null)
	{
		super(parent, xpos, ypos);
		_password = false;
		_text = "";
		_defaultText = text;
		this.text = text;
		if(defaultHandler != null)
		{
			addEventListener(Event.CHANGE, defaultHandler);
		}
	}
	
	/**
	 * Initializes the component.
	 */
	override function init():Void
	{
		super.init();
		setSize(Style.DEFAULT_BTN_WIDTH, Style.DEFAULT_BTN_HEIGHT);
	}
	
	/**
	 * Creates and adds child display objects.
	 */
	override function addChildren():Void
	{
		// [mck] up/over/down face
		_state = new Bitmap();
		addChild(_state);

		_back = new Sprite();
		addChild(_back);

		_tf = new TextField( );
		_tf.height = Style.DEFAULT_BTN_HEIGHT; // [mck] for some reason the default height is 100px
		// [mck] and for some reason this _tf.height overwrite the Component.hx height... don't know why
		
		#if flash
		_tf.embedFonts = Style.embedFonts;
		#end
		//_tf.border = true;
		_tf.selectable = true;
		_tf.type = TextFieldType.INPUT;
		_tf.defaultTextFormat = new TextFormat(Style.fontName, Style.fontSize, Style.INPUT_TEXT);
		
		addChild(_tf);
		_tf.addEventListener(Event.CHANGE, onChange);

		// [mck] remove the default string
		_tf.addEventListener(FocusEvent.FOCUS_IN, onFocusHandler);
		_tf.addEventListener(FocusEvent.FOCUS_OUT, onFocusHandler);
		
	}
	
	
	
	
	///////////////////////////////////
	// public methods
	///////////////////////////////////
	
	/**
	 * Draws the visual ui of the component.
	 */
	override public function draw():Void
	{
		super.draw();
		_back.graphics.clear();
		
		if(_addUpAsset == null){
			#if !flash
			_back.graphics.lineStyle(1, 0, 0.1);
			#end
			
			#if flash
			_back.graphics.beginFill(Style.BACKGROUND);
			#else
			_back.graphics.beginFill(Style.PANEL);
			#end
			
			_back.graphics.drawRect(0, 0, _width, _height);
			_back.graphics.endFill();
		} else {
			_state.bitmapData = _addUpAsset;
		}

		_tf.displayAsPassword = _password;
		
		_tf.text = _text;
		_tf.width = _width - 4;
		if(_tf.text == "")
		{
			_tf.text = "X";
			_tf.height = Math.min(_tf.textHeight + 4, _height);
			_tf.text = "";
		}
		else
		{
			_tf.height = Math.min(_tf.textHeight + 4, _height);
		}
		_tf.x = 2;
		_tf.y = Math.round(_height / 2 - _tf.height / 2);
	}
	
	
	
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	private function onFocusHandler(e : FocusEvent) : Void {
		// trace( "InputBoxBase.onFocusHandler > e : " + e );
		var contentTxt : String;
		if (e.type == FocusEvent.FOCUS_IN) {
			_state.bitmapData = _addDownAsset;
			contentTxt = _tf.text;
			if (contentTxt == _defaultText) {
				_tf.text = "";
				
			}
		} else if (e.type == FocusEvent.FOCUS_OUT) {
			_state.bitmapData = _addUpAsset;
			contentTxt = _tf.text;
			if (contentTxt == "") {
				_tf.text = _defaultText;
			}
		}
	}

	/**
	 * Internal change handler.
	 * @param event The Event passed by the system.
	 */
	function onChange(event:Event):Void
	{
		_text = _tf.text;
		event.stopImmediatePropagation();
		dispatchEvent(event);
	}
	
	
	
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Gets / sets the text shown in this InputText.
	 */
	public function setText(t:String):String
	{
		_text = t;
		invalidate();
		return t;
	}
	
	public function getText():String
	{
		if (_tf.text == _defaultText) {
			_text = "";
		}
		return _text;
	}
	
	/**
	 * Returns a reference to the internal text field in the component.
	 */
	public function getTextField():TextField
	{
		return _tf;
	}
	
	/**
	 * Gets / sets the list of characters that are allowed in this TextInput.
	 */
	public function setRestrict(str:String):String
	{
		#if flash
		_tf.restrict = str;
		#end
		return str;
	}
	
	public function getRestrict():String
	{
		#if flash
		return _tf.restrict;
		#else
		return "";
		#end
	}
	
	/**
	 * Gets / sets the maximum number of characters that can be shown in this InputText.
	 */
	public function setMaxChars(max:Int):Int
	{
		_tf.maxChars = max;
		return max;
	}
	
	public function getMaxChars():Int
	{
		return _tf.maxChars;
	}
	
	/**
	 * Gets / sets whether or not this input text will show up as password (asterisks).
	 */
	public function setPassword(b:Bool):Bool
	{
		_password = b;
		invalidate();
		return b;
	}
	public function getPassword():Bool
	{
		return _password;
	}

	/**
	 * Sets/gets whether this component is enabled or not.
	 */
	override public function setEnabled(value:Bool):Bool
	{
		super.setEnabled(value);
		#if flash
		_tf.tabEnabled = value;
		#end
		return value;
	}

}