module dhe.event.activekeybinding;

import dhe.event.keybinding;
import dhe.event.event;

private:
	bool enabled = true;
	Keybinding binding = null;
	void sdlListener(Event!("SDL", Keyboard) event){
		if(binding is null)
			return;	
		if(!enabled)
			return;

		binding.listen(event);
	}

public:
	/**
	 * Set, or unset the currently active keybinding. Only one can be active at
	 * one time, so they will not collide with eachother.
	 *
	 * Params:
	 *		binding = Keybindings that should react to the SDL events
	 */
	void activate(Keybinding binding){}

	/**
	 * Enable or disable the active keybinding temporarily.
	 */
	void enable(bool value = true){}
