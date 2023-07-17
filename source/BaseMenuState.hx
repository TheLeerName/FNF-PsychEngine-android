package;

import openfl.Lib;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup;

import input.AttachedHitbox;

/**
 * Used for easy adding menus
 */
class BaseMenuState<T:FlxObject> extends MusicBeatState {
	/**
	 * Current selected index on `menuItems`
	 */
	public var curSelected(default, set):Int = 0;
	/**
	 * Group with items for menu
	 */
	public var menuItems:FlxTypedGroup<T> = new FlxTypedGroup<T>();
	/**
	 * Calls on changed `curSelected`. You don't need do `super.changeSelection(value);` cuz it empty
	 * @param value Current selected index
	 */
	public function changeSelection(value:Int) {}
	/**
	 * Calls on `controls.ACCEPT`. You don't need do `super.accept();` cuz it empty
	 */
	public function accept() {}
	/**
	 * Calls on `controls.BACK`. You don't need do `super.back();` cuz it empty
	 */
	public function back() {}

	/**
	 * For tapping on selected object by pointer. To enable/disable, change `acceptHitbox.visible`. Works only in mobile!
	 */
	public var acceptHitbox:AttachedHitbox<T> = new AttachedHitbox<T>(null, 'accept');

	/**
	 * Set this to `false` if you want disable changing selection, `back` and `accept` calling
	 */
	public var allowControls:Bool = true;

	/**
	 * Make sure you adding objects above `super.create();`
	 */
	override function create() {

		add(menuItems);

		acceptHitbox.visible = controls.mobileInput;
		add(acceptHitbox);

		super.create();

		if (FlxG.save.data.states_curSelected == null)
			FlxG.save.data.states_curSelected = {};
		var value:Null<Int> = Reflect.getProperty(FlxG.save.data.states_curSelected, Type.getClassName(Type.getClass(this)));
		curSelected = value != null ? value : 0;

		Lib.application.window.onClose.add(destroy); // why it not calls on close app????????????????????????
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (allowControls) {
			if (controls.BACK) back();
			if (controls.ACCEPT) accept();
			if (controls.UI_UP_P) curSelected--;
			if (controls.UI_DOWN_P) curSelected++;
		}
	}

	override function destroy() {
		Reflect.setProperty(FlxG.save.data.states_curSelected, Type.getClassName(Type.getClass(this)), curSelected);
		FlxG.save.flush();

		super.destroy();
	}

	function set_curSelected(v:Int):Int {
		curSelected = v;
		if (curSelected >= menuItems.length) curSelected = 0;
		if (curSelected < 0) curSelected = menuItems.length - 1;

		changeSelection(curSelected);
		if (menuItems.length > 0) acceptHitbox.sprTracker = menuItems.members[curSelected];
		return v;
	}
}