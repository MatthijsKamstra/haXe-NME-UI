/**
* PushButton.as
* Keith Peters
* version 0.9.10
* 
* A basic button component with a label.
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

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextFormat;


class PushButton extends Component
{
	public var label(getLabel, setLabel):String;
	public var selected(getSelected, setSelected):Bool;
	public var toggle(getToggle, setToggle):Bool;
	
	var _back:Sprite;
	var _face:Sprite;
	var _label:Label;
	var _labelText:String;
	var _isOver:Bool;
	var _isDown:Bool;
	var _isSelected:Bool;
	var _isToggle:Bool;

	// skin-albe layers
	var _state:Bitmap;

	
	#if !flash
	var _clickableArea:Sprite;
	#end
	
	/**
	 * Constructor
	 * @param parent The parent DisplayObjectContainer on which to add this PushButton.
	 * @param xpos The x position to place this component.
	 * @param ypos The y position to place this component.
	 * @param label The string to use for the initial label of this component.
	 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
	 */
	public function new(?parent:Dynamic = null, ?xpos:Float = 0, ?ypos:Float =  0, ?label:String = "", ?defaultHandler:Dynamic = null)
	{
		_labelText = "";
		_isOver = false;
		_isDown = false;
		_isSelected = false;
		_isToggle = false;
		
		super(parent, xpos, ypos);
		if(defaultHandler != null)
		{
			addEventListener(MouseEvent.CLICK, defaultHandler);
			//addEventListener(UIEvent.CLICK, defaultHandler);
		}
		this.label = label;
	}
	
	/**
	 * Initializes the component.
	 */
	override function init():Void
	{
		super.init();
		buttonMode = true;
		useHandCursor = true;
		setSize(Style.DEFAULT_BTN_WIDTH, Style.DEFAULT_BTN_HEIGHT);
	}
	
	/**
	 * Creates and adds the child display objects of this component.
	 */
	override function addChildren():Void
	{
		// [mck] up/over/down face
		_state = new Bitmap();
		addChild(_state);

		_back = new Sprite();
		_back.mouseEnabled = false;
		addChild(_back);
		
		_face = new Sprite();
		_face.mouseEnabled = false;
		_face.x = 1;
		_face.y = 1;
		addChild(_face);
		
		_label = new Label();
		addChild(_label);
		
		#if !flash
		_clickableArea = new Sprite();
		_clickableArea.alpha = 0;
		addChild(_clickableArea);
		#end
		
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseGoDown);
		addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
	}
	
	/**
	 * Draws the face of the button, color based on state.
	 */
	function drawFace():Void
	{
		_face.graphics.clear();
		if (_addUpAsset == null){
			if(_isDown)
			{
				_face.graphics.beginFill(Style.BUTTON_DOWN);
			}
			else if (_isOver)
			{
				_face.graphics.beginFill(Style.BUTTON_OVER);
			}
			else
			{
				_face.graphics.beginFill(Style.BUTTON_FACE);
			}
			_face.graphics.drawRect(0, 0, _width - 2, _height - 2);
			_face.graphics.endFill();
		} else {
			
			if(_isDown){
				_state.bitmapData = _addDownAsset;
			} else {
				_state.bitmapData = _addUpAsset;
			}
		}
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
			_back.graphics.beginFill(Style.BACKGROUND);
			_back.graphics.drawRect(0, 0, _width, _height);
			_back.graphics.endFill();
		} 
		
		drawFace();
		
		_label.text = _labelText;
		_label.autoSize = true;
		_label.draw();
		if(_label.width > _width - 4)
		{
			_label.autoSize = false;
			_label.width = _width - 4;
		}
		else
		{
			_label.autoSize = true;
		}
		_label.draw();
		_label.move(_width / 2 - _label.width / 2, _height / 2 - _label.height / 2);
		
		#if !flash
		_clickableArea.graphics.clear();
		_clickableArea.graphics.beginFill(Style.BACKGROUND);
		_clickableArea.graphics.drawRect(0, 0, _width, _height);
		_clickableArea.graphics.endFill();
		#end
	}
	
	
	
	
	///////////////////////////////////
	// event handlers
	///////////////////////////////////
	
	/**
	 * Internal mouseOver handler.
	 * @param event The MouseEvent passed by the system.
	 */
	function onMouseOver(event:MouseEvent):Void
	{
		_isOver = true;
		if (_addOverAsset != null) _state.bitmapData = _addOverAsset;
		drawFace();
		addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
	}
	
	/**
	 * Internal mouseOut handler.
	 * @param event The MouseEvent passed by the system.
	 */
	function onMouseOut(event:MouseEvent):Void
	{
		_isOver = false;
		if(!_isDown)
		{
			if (_addUpAsset != null) _state.bitmapData = _addUpAsset;
		}
		drawFace();
		removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
	}
	
	/**
	 * Internal mouseOut handler.
	 * @param event The MouseEvent passed by the system.
	 */
	function onMouseGoDown(event:MouseEvent):Void
	{
		_isDown = true;
		drawFace();
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
	}
	
	/**
	 * Internal mouseUp handler.
	 * @param event The MouseEvent passed by the system.
	 */
	function onMouseGoUp(event:MouseEvent):Void
	{
		if(_isToggle  && _isOver)
		{
			_isSelected = !_isSelected;
		}
		_isDown = _isSelected;
		drawFace();
		stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseGoUp);
	}
	
	
	
	
	///////////////////////////////////
	// getter/setters
	///////////////////////////////////
	
	/**
	 * Sets / gets the label text shown on this Pushbutton.
	 */
	public function setLabel(str:String):String
	{
		_labelText = str;
		draw();
		return str;
	}
	public function getLabel():String
	{
		return _labelText;
	}

	public function setLabelFormat (format : Dynamic) : Void
	//public function setLabelFormat (format : TextFormat) : Void
	{
		_label.setFormat (format);
		invalidate ();
		draw();
	}
		
	public function setSelected(value:Bool):Bool
	{
		if(!_isToggle)
		{
			value = false;
		}
		
		_isSelected = value;
		_isDown = _isSelected;
		drawFace();
		return value;
	}
	public function getSelected():Bool
	{
		return _isSelected;
	}
	
	public function setToggle(value:Bool):Bool
	{
		_isToggle = value;
		return value;
	}
	public function getToggle():Bool
	{
		return _isToggle;
	}
	
	/********** Sprite composition ***************/
	override public function addEventListener(type:String, listener:Dynamic->Void, ?useCapture:Bool = false, ?priority:Int = 0, ?useWeakReference:Bool = false):Void 
	{
		#if flash
		super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		#else
		_clickableArea.addEventListener(type, listener, useCapture, priority, useWeakReference);
		#end
	}
	
	override public function removeEventListener(type:String, listener:Dynamic->Void, ?useCapture:Bool = false):Void 
	{
		
		#if flash
		super.removeEventListener(type, listener, useCapture);
		#else
		_clickableArea.removeEventListener(type, listener, useCapture);
		#end
	}
	
}
