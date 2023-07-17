package input;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.input.FlxInput;
import flixel.input.IFlxInput;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionInputDigital;

using StringTools;

/**
 * Creates hitbox with `IFlxInput` things. Variable `visible` works like `enabled`
 */
class Hitbox extends FlxSprite implements IFlxInput {
	public var justReleased(get, never):Bool;
	public var released(get, never):Bool;
	public var pressed(get, never):Bool;
	public var justPressed(get, never):Bool;

	public var alphaPressed:Float = 0.4;
	public var alphaReleased:Float = 0.2;

	public var name:String;

	public function new(x:Float, y:Float, width:Float, height:Float, color:FlxColor, controlName:String) {
		super(x, y);
		makeGraphic(Math.floor(width), Math.floor(height), color);

		name = controlName;
		if (controlName.startsWith('note_') || controlName.startsWith('ui_')) {
			addInput('_' + controlName,       PRESSED);
			addInput('_' + controlName + 'P', JUST_PRESSED);
			addInput('_' + controlName + 'R', JUST_RELEASED);
		}
		else
			addInput('_' + controlName, JUST_PRESSED);
	}

	var addedInputs:Array<FlxActionInputDigitalIFlxInput> = [];
	override function destroy() {
		for (i => k in addedInputs) {
			k.destroy();
			removeInput('_' + name,       k, true);
			removeInput('_' + name + 'P', k, true);
			removeInput('_' + name + 'R', k, true);
		}
		addedInputs = [];
		super.destroy();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		alpha = pressed ? alphaPressed : alphaReleased;
	}

	function addInput(controlName:String, trigger:FlxInputState) {
		var field:FlxActionDigital = cast Reflect.getProperty(Controls.instance, controlName);
		if (field != null) {
			var action = new FlxActionInputDigitalIFlxInput(this, trigger);
			addedInputs.push(action);
			field.add(action);
		}
	}

	function removeInput(controlName:String, action:FlxActionInputDigitalIFlxInput, destroy:Bool = false) {
		var field:FlxActionDigital = cast Reflect.getProperty(Controls.instance, controlName);
		if (field != null) {
			field.remove(action, destroy);
		}
	}

	function check(trigger:FlxInputState) {
		if (visible && exists) {
			#if mobile
			for (touch in FlxG.touches.list)
			#else
			var touch = FlxG.mouse;
			#end
			if (getScreenBounds(null, cameras[0]).containsPoint(touch.getScreenPosition(cameras[0]))) {
				switch(trigger) {
					case JUST_RELEASED: return touch.justReleased;
					case RELEASED: return touch.released;
					case PRESSED: return touch.pressed;
					case JUST_PRESSED: return touch.justPressed;
				}
			}
		}

		return trigger == RELEASED;
	}

	inline function get_justReleased():Bool return check(JUST_RELEASED);
	inline function get_released():Bool return check(RELEASED);
	inline function get_pressed():Bool return check(PRESSED);
	inline function get_justPressed():Bool return check(JUST_PRESSED);
}