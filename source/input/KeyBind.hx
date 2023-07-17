package input;

import flixel.input.keyboard.FlxKey;

/**
 * This class takes keys from `ClientPrefs.keyBinds` and uses it like `IFlxInput` classes. Variable `visible` works like `enabled`
 */
class KeyBind implements IFlxInput {
	public var name:String = "";

	public var justReleased(get, never):Bool;
	public var released(get, never):Bool;
	public var pressed(get, never):Bool;
	public var justPressed(get, never):Bool;

	public var visible:Bool = true;

	public function new(name:String) {
		this.name = name;
	}

	inline function get_justReleased():Bool return FlxG.keys.anyJustReleased(get(name));
	inline function get_released():Bool return !FlxG.keys.anyPressed(get(name));
	inline function get_pressed():Bool return FlxG.keys.anyPressed(get(name));
	inline function get_justPressed():Bool return FlxG.keys.anyJustPressed(get(name));

	function get(name:String):Array<FlxKey> return visible ? ClientPrefs.copyKey(ClientPrefs.keyBinds[name]) : [];
}