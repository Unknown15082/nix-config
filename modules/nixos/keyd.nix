{
	services.keyd.enable = true;
	services.keyd.keyboards = {
		default = {
			ids = [ "*" ];
			settings = {
				main = {
					# Change CapsLock key to Control/Escape (Hold-Tap)
					capslock = "overload(control, esc)";
				};
			};
		};
	};
}
