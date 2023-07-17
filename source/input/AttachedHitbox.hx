package input;

import flixel.FlxSprite;

/**
 * Works like `Hitbox` class, but attached to `sprTracker`
 */
class AttachedHitbox extends Hitbox {
	public var sprTracker:FlxSprite;

	public function new(sprTracker:FlxSprite, controlName:String) {
		super(sprTracker.x, sprTracker.y, sprTracker.width, sprTracker.height, 0, controlName);
		alphaPressed = alphaReleased = alpha = 0;
	}

	override function update(elapsed:Float) {
		if (sprTracker != null) {
			setPosition(sprTracker.x, sprTracker.y);
			setSize(sprTracker.width, sprTracker.height);
		}

		super.update(elapsed);
	}
}