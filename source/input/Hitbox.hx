package input;

import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.input.FlxInput;
import flixel.input.actions.FlxAction;
import flixel.input.actions.FlxActionInputDigital;

using StringTools;

/**
 * Creates hitbox with `IFlxInput` things. Variable `visible` works like `enabled`
 */
class Hitbox extends FlxTypedButton<FlxSprite> {
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
		if (lastStatus == 1 && status == 1 && released && justReleased)
			input.release(); // justReleased must be only in 1 frame!!!!

		if (!visible) input.release();

		alpha = pressed ? alphaPressed : alphaReleased;

		super.update(elapsed);
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
}