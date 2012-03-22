package;

import nl.emceekay.ui.InputText;
import nl.emceekay.ui.CheckBox;
import nl.emceekay.ui.PushButton;
import nl.emceekay.ui.VBox;

import nme.Lib;
import nme.events.Event;
import nme.display.Sprite;

class UIMain extends Sprite 
{
	public function new()
	{
		super();

		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e):Void 
	{
		// Entry point
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ nme.system.Capabilities.screenDPI
		
		// Assets:
		// nme.Assets.getBitmapData("assets/assetname.jpg");

		var _vbox0 = new nl.emceekay.ui.VBox(this, 10 , 10);
		_vbox0.spacing = 20;


		var _btn0 = new nl.emceekay.ui.PushButton(_vbox0, 0,0, 'PushButton Android', onClickHandler); 
		_btn0.name = "pushbutton0";
		_btn0.addUpAsset = nme.Assets.getBitmapData("assets/android_ui/button_up.png");
		_btn0.addDownAsset = nme.Assets.getBitmapData("assets/android_ui/button_down.png");


		var _input0 = new nl.emceekay.ui.InputText(_vbox0, 0,0,"InputText Android",onChangeHandler);
		_input0.name = "inputtext0";
		_input0.addDownAsset = nme.Assets.getBitmapData("assets/android_ui/input_down.png");
		_input0.addUpAsset = nme.Assets.getBitmapData("assets/android_ui/input_up.png");


		var _checkbox0 = new nl.emceekay.ui.CheckBox(_vbox0,0,0,"CheckBox Android",onCheckHandler);
		_checkbox0.name = "checkbox0";
		_checkbox0.addUpAsset = nme.Assets.getBitmapData("assets/android_ui/checkbox_uncheck.png");
		_checkbox0.addDownAsset = nme.Assets.getBitmapData("assets/android_ui/checkbox_check.png");


		var _radio0	= new nl.emceekay.ui.RadioButton(_vbox0, 0,0, "RadioButton Android 1",true);
		_radio0.name = "radio0";
		_radio0.addUpAsset = nme.Assets.getBitmapData("assets/android_ui/radio_unselect.png");
		_radio0.addDownAsset = nme.Assets.getBitmapData("assets/android_ui/radio_select.png");

		var _radio1	= new nl.emceekay.ui.RadioButton(_vbox0, 0,0, "RadioButton Android 2");
		_radio1.name = "radio1";
		_radio1.addUpAsset = nme.Assets.getBitmapData("assets/android_ui/radio_unselect.png");
		_radio1.addDownAsset = nme.Assets.getBitmapData("assets/android_ui/radio_select.png");
		
		var _radio2	= new nl.emceekay.ui.RadioButton(_vbox0, 0,0, "RadioButton Android 3");
		_radio2.name = "radio2";
		_radio2.addUpAsset = nme.Assets.getBitmapData("assets/android_ui/radio_unselect.png");
		_radio2.addDownAsset = nme.Assets.getBitmapData("assets/android_ui/radio_select.png");


		#if flash
		var _vbox1 = new nl.emceekay.ui.VBox(this, 400 , 10);
		_vbox1.spacing = 20;

		
		var _btn1 = new nl.emceekay.ui.PushButton(_vbox1, 0,0, 'PushButton', onClickHandler); 
		_btn1.name = "pushbutton1";

		var _input1 = new nl.emceekay.ui.InputText(_vbox1, 0,0,"InputText",onChangeHandler);
		_input1.name = "inputtext1";

		var _checkbox1 = new nl.emceekay.ui.CheckBox(_vbox1,0,0,"CheckBox",onCheckHandler);
		_checkbox1.name = "checkbox1";

		var _radio00	= new nl.emceekay.ui.RadioButton(_vbox1, 0,0, "RadioButton 1",true);
		_radio00.name = "radio00";

		var _radio01	= new nl.emceekay.ui.RadioButton(_vbox1, 0,0, "RadioButton 2");
		_radio01.name = "radio01";
		
		var _radio02	= new nl.emceekay.ui.RadioButton(_vbox1, 0,0, "RadioButton 3");
		_radio02.name = "radio02";
		#end
	}
	

	private function onClickHandler (e:Event):Void
	{
		// trace("onClickHandler e: " + e);
		var _name = e.currentTarget.name;
		
		switch (_name) {
			case 'pushbutton0':
				// do something connected to pushbutton0
			case 'pushbutton1':
				// do something connected to pushbutton1
			default: 
				trace("// + onClickHandler");
				trace("case '" + _name + "':\r\ttrace ('--- " + _name + "');\r\tbreak;");
		}
	}

	private function onCheckHandler(e:Event) :Void
	{
		//trace ("onCheckHandler e:"+ [e]);
		var _name = e.currentTarget.name;

		switch (_name) {
			case 'checkbox0':
				// do something connected to checkbox0
			case 'checkbox1':
				// do something connected to checkbox1
			default: 
				trace("// + onCheckHandler");
				trace("case '" + _name + "':\r\ttrace ('--- " + _name + "');\r\tbreak;");
		}
	}

	private function onChangeHandler(e:Event) :Void
	{
		//trace ("onChangeHandler e:"+ [e]);
		var _name = e.currentTarget.name;

		switch (_name) {
			case 'inputtext0':
				// do something connected to inputtext0
			case 'inputtext1':
				// do something connected to inputtext1
			default: 
				trace("// + onChangeHandler");
				trace("case '" + _name + "':\r\ttrace ('--- " + _name + "');\r\tbreak;");
		}
	}

	public static function main() 
	{
		// Static entry point
		Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new UIMain());
	}
}
