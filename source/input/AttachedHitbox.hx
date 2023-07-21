package input;

import flixel.FlxObject;
import flixel.util.FlxColor;

/**
 * Works like `Hitbox` class, but attached to `sprTracker`. Hitbox itself is invisible, but you can change `alphaPressed`/`alphaReleased` for it
 */
class AttachedHitbox extends Hitbox {
	public var sprTracker:FlxObject;

	public function new(controlName:String, ?color:FlxColor = 0xffff0000, ?sprTracker:FlxObject) {
		super(0, 0, 1, 1, 0xffffffff, controlName);
		this.color = color;

		this.sprTracker = sprTracker;
		alphaPressed = alphaReleased = alpha = 0;
		//alphaReleased = 0.5; // lol visible hitbox
	}

	override function update(elapsed:Float) {
		if (sprTracker != null && visible) {
			setPosition(sprTracker.x, sprTracker.y);
			scale.set(sprTracker.width, sprTracker.height);
			if (alpha != 0) updateHitbox();
			scrollFactor.set(sprTracker.scrollFactor.x, sprTracker.scrollFactor.y);
		}
		else {
			setPosition(0, 0);
			scale.set(1, 1);
			if (alpha != 0) updateHitbox();
			scrollFactor.set(0, 0);
		}

		super.update(elapsed);
	}
}