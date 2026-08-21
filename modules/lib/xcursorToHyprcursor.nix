{ lib, ... }: {
	flake.lib.xcursorToHyprcursor =
		{
		pkgs
		, xcursorPackage
		, themeName
		, ...
		}:
		pkgs.stdenvNoCC.mkDerivation {
			pname = "${lib.toLower themeName}-hyprcursor";
			version = xcursorPackage.version or "unstable";

			dontUnpack = true;
			nativeBuildInputs = [
				pkgs.hyprcursor
				pkgs.xcur2png
			];

			buildPhase = ''
				runHook preBuild
				mkdir -p extracted compiled
				hyprcursor-util --extract ${xcursorPackage}/share/icons/${themeName} --output extracted
				hyprcursor-util --create extracted/extracted_${themeName} --output compiled
				runHook postBuild
			'';

			installPhase = ''
				runHook preInstall
				mkdir -p $out/share/icons
				cp -r ${xcursorPackage}/share/icons/${themeName} $out/share/icons/${themeName}
				chmod -R u+w $out/share/icons/${themeName}
				cp -r compiled/theme_Extracted\ Theme/hyprcursors $out/share/icons/${themeName}/
				cp compiled/theme_Extracted\ Theme/manifest.hl $out/share/icons/${themeName}/
				runHook postInstall
			'';

			meta.platforms = lib.platforms.linux;
		};
}
