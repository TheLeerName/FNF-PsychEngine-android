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
	var curSelected(default, set):Int = 0;
	/**
	 * Group with items for menu
	 */
	var menuItems:FlxTypedGroup<T> = new FlxTypedGroup<T>();
	/**
	 * For tapping on selected object by pointer. To enable/disable, change `acceptHitbox.visible`. Works only in mobile!
	 */
	var acceptHitbox:AttachedHitbox<T> = new AttachedHitbox<T>(null, 'accept');
	/**
	 * Set this to `false` if you want disable changing selection, `back` and `accept` calling
	 */
	var allowControls:Bool = true;
	/**
	 * If `SHIFT` pressed, selection changes by this value
	 */
	var shiftMult:Int = 1;
	/**
	 * Minimum hold time in seconds from where will be registered holding down or up keys
	 */
	var minHoldTime:Float = 0.5;

	/**
	 * Calls on changed `curSelected`. You don't need do `super.changeSelection(value);` cuz it empty
	 * @param value Current selected index
	 */
	function changeSelection(value:Int) {}
	/**
	 * Calls on `controls.ACCEPT`. You don't need do `super.accept();` cuz it empty
	 */
	function accept() {}
	/**
	 * Calls on `controls.BACK`. You don't need do `super.back();` cuz it empty
	 */
	function back() {}

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

	var holdTime:Float = 0;
	override function update(elapsed:Float) {
		super.update(elapsed);

		if (allowControls) {
			if (controls.BACK) back();
			if (controls.ACCEPT) accept();
			if (controls.UI_UP_P) {
				curSelected -= shiftMult;
				holdTime = 0;
			}
			if (controls.UI_DOWN_P) {
				curSelected += shiftMult;
				holdTime = 0;
			}

			if(controls.UI_DOWN || controls.UI_UP)
			{
				var checkLastHold:Int = Math.floor((holdTime - minHoldTime) * 10);
				holdTime += elapsed;
				var checkNewHold:Int = Math.floor((holdTime - minHoldTime) * 10);

				if(holdTime > minHoldTime && checkNewHold - checkLastHold > 0)
					curSelected += (checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult);
			}
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