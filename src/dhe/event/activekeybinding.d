module dhe.event.activekeybinding;

import dhe.event.keybinding;
import dhe.event.event;

import std.concurrency;
import core.thread;

private:
Keybinding[] bindings;

void sdlListener(Event!("SDL", immutable Keyboard) event){
	foreach(Keybinding binding; bindings){
		if(binding is null) continue;
		binding.shout(event);
	}
}

public:
/**
 * Add to the currently active keybindings. While any of the keybindings are
 * allowed to collide. It's not recommended to utilize this, since threads
 * are very non-deterministic.
 *
 * Params:
 *		binding = Keybindings that should react to the SDL events
 */
void addKeybinding(Keybinding binding){
	bindings ~= binding;
}

/**
 * Remove a previously added keybinding
 */
void removeKeybinding(Keybinding binding){
	Keybinding[] result;
	if(binding is null) return;
	foreach(Keybinding item; bindings){
		if(item !is binding){
			result ~= item;
		}
	}
	bindings.clear();
	bindings = result;
}
unittest{
	Keybinding bind = new Keybinding();
	Keybinding bind2 = new Keybinding();
	Keybinding bind3 = new Keybinding();
	addKeybinding(bind);
	addKeybinding(bind2);

	assert(bindings == [bind, bind2], "Adding bindings to active keybindings failed");

	removeKeybinding(bind2);
	assert(bindings == [bind], "Couldn't remove a binding from active keybindings");

	removeKeybinding(bind2);
	assert(bindings == [bind], 
		   "Removing a nonstored binding from active keybindings should do anything");

	removeKeybinding(bind);
	assert(bindings == [], "Couldn't remove the only binding from active keybindings");

	removeKeybinding(bind);
	assert(bindings == [], "Removing binding from an empty active keybindings failed");
}
