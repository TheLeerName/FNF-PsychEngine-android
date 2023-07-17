package input;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.FlxInput;
import flixel.input.IFlxInput;

/**
 * Works like `Hitbox` class, but attached to `sprTracker`, and not extends `FlxSprite`. Variable `visible` works like `enabled`
 */
class AttachedHitbox implements IFlxInput {
    public var justReleased(get, never):Bool;
	public var released(get, never):Bool;
	public var pressed(get, never):Bool;
	public var justPressed(get, never):Bool;

    public var sprTracker:FlxSprite;

    public var visible:Bool = true;

    function check(trigger:FlxInputState) {
		if (visible && sprTracker != null) {
			#if mobile
			for (touch in FlxG.touches.list)
			#else
			var touch = FlxG.mouse;
			#end
			if (sprTracker.getScreenBounds(null, sprTracker.cameras[0]).containsPoint(touch.getScreenPosition(sprTracker.cameras[0]))) {
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