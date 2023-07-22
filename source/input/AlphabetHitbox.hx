package input;

import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;

class AlphabetHitbox extends FlxSpriteGroup {
	public var hitbox(default, null):Hitbox;
	public var label(default, null):Alphabet;

	public var doRainbowThingy:Bool = true;
	public var speed:Float = FlxG.random.float(1, 2.5);
	public var hue:Float = FlxG.random.float(0, 360);

	override function set_visible(v:Bool):Bool {
		visible = super.set_visible(v);
		if (hitbox != null) hitbox.visible = visible;
		return visible;
	}

	public function new(x:Float, y:Float, offset:Float = 20, labelScale:Float = 1, text:String, ?controlName:String) {
		super(x, y);

		hitbox = new Hitbox(0, 0, 1, 1, 0xffffffff, controlName);
		hitbox.scrollFactor.set();
		add(hitbox);

		label = new Alphabet(offset, offset, text);
		label.scrollFactor.set();
		label.scaleX = labelScale;
		label.scaleY = labelScale;
		add(label);

		hitbox.setGraphicSize(Math.floor(label.width + offset), Math.floor(label.height + offset));
		hitbox.updateHitbox();
	}

	override function update(elapsed:Float) {
		if (doRainbowThingy) {
			hue += speed;
			hitbox.color = FlxColor.fromHSB(hue, 1, 1, 1);
		}

		super.update(elapsed);
	}
}