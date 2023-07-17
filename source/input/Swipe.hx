package input;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.input.FlxInput;
import flixel.input.IFlxInput;

/**
 * Swipes system like `IFlxInput` classes. Variable `visible` works like `enabled`
 */
class Swipe implements IFlxInput {
	public var justReleased(get, never):Bool;
	public var released(get, never):Bool;
	public var pressed(get, never):Bool;
	public var justPressed(get, never):Bool;

	public var name:String;

	public var visible:Bool = true;

	/**
	 * If initial mouse pos beyond `deadZone`, swipe will be registered
	 */
	public var deadZone:Float = 25;
	/**
	 * In which degrees swipes will work
	 */
	public var degreesOffset:Float = 25;

	public function new(name:String) {
		this.name = name;
	}

	inline function get_justReleased():Bool return check(JUST_RELEASED);
	inline function get_released():Bool return check(RELEASED);
	inline function get_pressed():Bool return check(PRESSED);
	inline function get_justPressed():Bool return check(JUST_PRESSED);

	var mousePos:FlxPoint = FlxPoint.get();
	function check(trigger:FlxInputState):Bool {
		if (!visible) return trigger == RELEASED;
		switch(trigger) {
			case JUST_RELEASED:
				if (!FlxG.mouse.justReleased) return false;
				return check(PRESSED); // idk not checked how it work
			case RELEASED:
				return !check(PRESSED);
			case PRESSED:
				if (FlxG.mouse.justPressed) mousePos = FlxG.mouse.getPosition();
				if (!FlxG.mouse.pressed) return false;
				switch (name) {
					case "ui_down":
						return FlxG.mouse.y - deadZone > mousePos.y;
					case "ui_up":
						return FlxG.mouse.y + deadZone < mousePos.y;
					case "ui_left":
						return FlxG.mouse.x + deadZone < mousePos.x;
					case "ui_right":
						return FlxG.mouse.x - deadZone > mousePos.x;
				}
			case JUST_PRESSED:
				if (FlxG.swipes.length == 0) return false; // cuz game will crash without it
				switch (name) {
					case "ui_down":
						return FlxG.swipes[0].degrees > 0 && (FlxG.swipes[0].distance >= deadZone && Math.abs(FlxG.swipes[0].degrees) >= 90 - degreesOffset && Math.abs(FlxG.swipes[0].degrees) <= 90 + degreesOffset);
					case "ui_up":
						return FlxG.swipes[0].degrees < 0 && (FlxG.swipes[0].distance >= deadZone && Math.abs(FlxG.swipes[0].degrees) >= 90 - degreesOffset && Math.abs(FlxG.swipes[0].degrees) <= 90 + degreesOffset);
					case "ui_left":
						return Math.abs(FlxG.swipes[0].degrees) > 90 && (FlxG.swipes[0].distance >= deadZone && Math.abs(FlxG.swipes[0].degrees) >= 180 - degreesOffset && Math.abs(FlxG.swipes[0].degrees) <= 180 + degreesOffset);
					case "ui_right":
						return Math.abs(FlxG.swipes[0].degrees) < 90 && (FlxG.swipes[0].distance >= deadZone && Math.abs(FlxG.swipes[0].degrees) >= -degreesOffset && Math.abs(FlxG.swipes[0].degrees) <= degreesOffset);
				}
		}
		return trigger == RELEASED;
	}
}