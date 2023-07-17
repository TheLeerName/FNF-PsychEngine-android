package input;

import flixel.FlxObject;

/**
 * Works like `Hitbox` class, but attached to `sprTracker`
 */
class AttachedHitbox<T:FlxObject> extends Hitbox {
	public var sprTracker:T;

	public function new(sprTracker:T, controlName:String) {
		super(0, 0, 0, 0, 0, controlName);

		this.sprTracker = sprTracker;
		alphaPressed = alphaReleased = alpha = 0;
	}

	override function update(elapsed:Float) {
		if (sprTracker != null) {
			setPosition(sprTracker.x, sprTracker.y);
			setSize(sprTracker.width, sprTracker.height);
		}
		else {
			setPosition(0, 0);
			setSize(0, 0);
		}

		super.update(elapsed);
	}
}