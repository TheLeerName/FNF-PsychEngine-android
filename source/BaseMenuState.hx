package;

import openfl.Lib;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxSprite;
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
	var acceptHitbox:AttachedHitbox = new AttachedHitbox('accept');
	/**
	 * Whether `acceptHitbox` need to be used (for example if menu not uses `controls.ACCEPT` you need set it to `false`)
	 */
	var useAcceptHitbox:Bool = true;
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
	 * Time passed on state in seconds
	 */
	var timePassedOnState:Float = 0;
	/**
	 * Whether `create()` function ended
	 */
	var initialized:Bool = false;

	/**
	 * Calls on changed `curSelected`. You don't need do `super.changeSelection(change);` cuz it empty
	 * @param change `curSelected` changed by this value
	 */
	function changeSelection(change:Int) {}
	/**
	 * Calls on `controls.ACCEPT`. You don't need do `super.accept();` cuz it empty
	 */
	function accept() {}
	/**
	 * Calls on `controls.BACK`. You don't need do `super.back();` cuz it empty
	 */
	function back() {}

	/**
	 * Sets `obj` object to `pos` position
	 * @param obj Object to reorder
	 * @param pos New position of object
	 */
	function setObjectOrder(obj:FlxBasic, pos:Int) {
		remove(obj, true);
		insert(pos, obj);
	}

	/**
	 * Returns position of `obj` object
	 * @param obj Object to get position
	 */
	function getObjectOrder(obj:FlxBasic) {
		return members.indexOf(obj);
	}

	/**
	 * Make sure you adding objects above `super.create();`
	 */
	override function create() {
		insert(1, menuItems);

		if (useAcceptHitbox) {
			acceptHitbox.visible = controls.mobileInput;
			add(acceptHitbox);
		}

		super.create();

		Lib.application.window.onClose.add(destroy); // why it not calls on close app????????????????????????
	}

	var holdTime:Float = 0;
	override function update(elapsed:Float) {
		super.update(elapsed);

		if (!initialized) {
			if (FlxG.save.data.states_curSelected == null)
				FlxG.save.data.states_curSelected = {};
			var value:Null<Int> = Reflect.getProperty(FlxG.save.data.states_curSelected, Type.getClassName(Type.getClass(this)));

			curSelected = value != null ? value : 0;
			initialized = true;
		}
		timePassedOnState += elapsed;

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
		if (v >= menuItems.length) v = 0;
		if (v < 0) v = menuItems.length - 1;

		var change:Int = v - curSelected;
		curSelected = v;
		changeSelection(change);
		if (menuItems.length > 0) acceptHitbox.sprTracker = menuItems.members[v];
		return curSelected = v;
	}
}