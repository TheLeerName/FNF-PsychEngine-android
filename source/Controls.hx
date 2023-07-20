package;

import flixel.FlxBasic;
import flixel.input.FlxInput;
import flixel.input.IFlxInput;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionSet;
#if android
import flixel.input.android.FlxAndroidKey;
#end

import input.KeyBind;
import input.Swipe;

using StringTools;

/**
 * A list of actions that a player would invoke via some input device.
 * Uses FlxActions to funnel various inputs to a single action.
 */
class Controls extends FlxActionSet
{
	var _ui_up:FlxActionDigital = new FlxActionDigital();
	var _ui_left:FlxActionDigital = new FlxActionDigital();
	var _ui_right:FlxActionDigital = new FlxActionDigital();
	var _ui_down:FlxActionDigital = new FlxActionDigital();
	var _ui_upP:FlxActionDigital = new FlxActionDigital();
	var _ui_leftP:FlxActionDigital = new FlxActionDigital();
	var _ui_rightP:FlxActionDigital = new FlxActionDigital();
	var _ui_downP:FlxActionDigital = new FlxActionDigital();
	var _ui_upR:FlxActionDigital = new FlxActionDigital();
	var _ui_leftR:FlxActionDigital = new FlxActionDigital();
	var _ui_rightR:FlxActionDigital = new FlxActionDigital();
	var _ui_downR:FlxActionDigital = new FlxActionDigital();
	var _note_up:FlxActionDigital = new FlxActionDigital();
	var _note_left:FlxActionDigital = new FlxActionDigital();
	var _note_right:FlxActionDigital = new FlxActionDigital();
	var _note_down:FlxActionDigital = new FlxActionDigital();
	var _note_upP:FlxActionDigital = new FlxActionDigital();
	var _note_leftP:FlxActionDigital = new FlxActionDigital();
	var _note_rightP:FlxActionDigital = new FlxActionDigital();
	var _note_downP:FlxActionDigital = new FlxActionDigital();
	var _note_upR:FlxActionDigital = new FlxActionDigital();
	var _note_leftR:FlxActionDigital = new FlxActionDigital();
	var _note_rightR:FlxActionDigital = new FlxActionDigital();
	var _note_downR:FlxActionDigital = new FlxActionDigital();
	var _accept:FlxActionDigital = new FlxActionDigital();
	var _back:FlxActionDigital = new FlxActionDigital();
	var _pause:FlxActionDigital = new FlxActionDigital();
	var _reset:FlxActionDigital = new FlxActionDigital();
	var _debug_1:FlxActionDigital = new FlxActionDigital();
	var _debug_2:FlxActionDigital = new FlxActionDigital();

	public var UI_UP(get, never):Bool;
	inline function get_UI_UP() return _ui_up.check();

	public var UI_LEFT(get, never):Bool;
	inline function get_UI_LEFT() return _ui_left.check();

	public var UI_RIGHT(get, never):Bool;
	inline function get_UI_RIGHT() return _ui_right.check();

	public var UI_DOWN(get, never):Bool;
	inline function get_UI_DOWN() return _ui_down.check();

	public var UI_UP_P(get, never):Bool;
	inline function get_UI_UP_P() return _ui_upP.check();

	public var UI_LEFT_P(get, never):Bool;
	inline function get_UI_LEFT_P() return _ui_leftP.check();

	public var UI_RIGHT_P(get, never):Bool;
	inline function get_UI_RIGHT_P() return _ui_rightP.check();

	public var UI_DOWN_P(get, never):Bool;
	inline function get_UI_DOWN_P() return _ui_downP.check();

	public var UI_UP_R(get, never):Bool;
	inline function get_UI_UP_R() return _ui_upR.check();

	public var UI_LEFT_R(get, never):Bool;
	inline function get_UI_LEFT_R() return _ui_leftR.check();

	public var UI_RIGHT_R(get, never):Bool;
	inline function get_UI_RIGHT_R() return _ui_rightR.check();

	public var UI_DOWN_R(get, never):Bool;
	inline function get_UI_DOWN_R() return _ui_downR.check();

	public var NOTE_UP(get, never):Bool;
	inline function get_NOTE_UP() return _note_up.check();

	public var NOTE_LEFT(get, never):Bool;
	inline function get_NOTE_LEFT() return _note_left.check();

	public var NOTE_RIGHT(get, never):Bool;
	inline function get_NOTE_RIGHT() return _note_right.check();

	public var NOTE_DOWN(get, never):Bool;
	inline function get_NOTE_DOWN() return _note_down.check();

	public var NOTE_UP_P(get, never):Bool;
	inline function get_NOTE_UP_P() return _note_upP.check();

	public var NOTE_LEFT_P(get, never):Bool;
	inline function get_NOTE_LEFT_P() return _note_leftP.check();

	public var NOTE_RIGHT_P(get, never):Bool;
	inline function get_NOTE_RIGHT_P() return _note_rightP.check();

	public var NOTE_DOWN_P(get, never):Bool;
	inline function get_NOTE_DOWN_P() return _note_downP.check();

	public var NOTE_UP_R(get, never):Bool;
	inline function get_NOTE_UP_R() return _note_upR.check();

	public var NOTE_LEFT_R(get, never):Bool;
	inline function get_NOTE_LEFT_R() return _note_leftR.check();

	public var NOTE_RIGHT_R(get, never):Bool;
	inline function get_NOTE_RIGHT_R() return _note_rightR.check();

	public var NOTE_DOWN_R(get, never):Bool;
	inline function get_NOTE_DOWN_R() return _note_downR.check();

	public var ACCEPT(get, never):Bool;
	inline function get_ACCEPT() return _accept.check();

	public var BACK(get, never):Bool;
	inline function get_BACK() return _back.check();

	public var PAUSE(get, never):Bool;
	inline function get_PAUSE() return _pause.check();

	public var RESET(get, never):Bool;
	inline function get_RESET() return _reset.check();
	
	public var DEBUG_1(get, never):Bool;
	inline function get_DEBUG_1() return _debug_1.check();
	
	public var DEBUG_2(get, never):Bool;
	inline function get_DEBUG_2() return _debug_2.check();

	public static var instance:Controls;

	public var keybinds:Array<KeyBind> = [];
	public var swipes:Array<Swipe> = [];

	public var mobileInput(default, set):Bool;
	inline function set_mobileInput(v:Bool):Bool {
		for (i => k in swipes) k.visible = v;
		return mobileInput = v;
	}

	public function new(?name:String)
	{
		super(name);

		instance = this;

		add(_ui_up);
		add(_ui_left);
		add(_ui_right);
		add(_ui_down);
		add(_ui_upP);
		add(_ui_leftP);
		add(_ui_rightP);
		add(_ui_downP);
		add(_ui_upR);
		add(_ui_leftR);
		add(_ui_rightR);
		add(_ui_downR);
		add(_note_up);
		add(_note_left);
		add(_note_right);
		add(_note_down);
		add(_note_upP);
		add(_note_leftP);
		add(_note_rightP);
		add(_note_downP);
		add(_note_upR);
		add(_note_leftR);
		add(_note_rightR);
		add(_note_downR);
		add(_accept);
		add(_back);
		add(_pause);
		add(_reset);

		// init keybinds (will take keys from keyBinds map directly)
		for (k => v in ClientPrefs.keyBinds) {
			keybinds.push(new KeyBind(k));
			if (k.startsWith('ui_') || k.startsWith('note_')) {
				addInput('_${k}',  keybinds[keybinds.length - 1], PRESSED);
				addInput('_${k}P', keybinds[keybinds.length - 1], JUST_PRESSED);
				addInput('_${k}R', keybinds[keybinds.length - 1], JUST_RELEASED);
			} else {
				addInput('_${k}',  keybinds[keybinds.length - 1], JUST_PRESSED);
			}
		}

		// init swipes
		var dirs = ['left', 'down', 'up', 'right'];
		for (k in dirs) swipes.push(new Swipe('ui_' + k));
		for (i => swipe in swipes) {
			addInput('_ui_' + dirs[i], swipe, PRESSED);
			addInput('_ui_' + dirs[i] + 'P', swipe, JUST_PRESSED);
			addInput('_ui_' + dirs[i] + 'R', swipe, JUST_RELEASED);
		}

		mobileInput = #if mobile true #else false #end;

		#if android
		_back.addAndroidKey(FlxAndroidKey.BACK, JUST_PRESSED);
		_pause.addAndroidKey(FlxAndroidKey.BACK, JUST_PRESSED);
		#end
	}

	public function addInput(actionName:String, input:IFlxInput, trigger:FlxInputState) {
		var field:FlxActionDigital = cast Reflect.getProperty(this, actionName);
		if (field != null) field.addInput(input, trigger);
	}
}