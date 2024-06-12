package objects;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	public var xAdd:Float = 12; // allow for more fun offset stuff
	public var yAdd:Float = -30; // and to fix winning icons kekw
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

	public function new(char:String = 'bf', isPlayer:Bool = false, ?allowGPU:Bool = true)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char, allowGPU);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + xAdd, sprTracker.y + yAdd);
	}

	private var iconOffsets:Array<Float> = [0, 0, 0]; // Added a third offset

public function changeIcon(char:String, ?allowGPU:Bool = true) {
	if(this.char != char) {
		var name:String = 'icons/' + char;
		if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
		if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
		
		var graphic = Paths.image(name, allowGPU);
		loadGraphic(graphic, true, Math.floor(graphic.width / 3), Math.floor(graphic.height)); // Each part is now a third of the width

		// Check if the graphic width is sufficient for three parts
		if (graphic.width < 450) {
			// Fallback to older version handling (split into two)
			loadGraphic(graphic, true, Math.floor(graphic.width / 2), Math.floor(graphic.height)); 
			iconOffsets[0] = (width - 300) / 2; // Updated to reflect the two-part division
			iconOffsets[1] = (height - 150) / 2;
			iconOffsets[2] = 0; // No third offset in older version
		} else {
			iconOffsets[0] = (width - 450) / 3; // Updated to reflect the third division
			iconOffsets[1] = (height - 150) / 2;
			iconOffsets[2] = (width - 450) / 3;
		}
		
		updateHitbox();

		// Adjust frames for the correct number of parts
		var frameCount = (graphic.width < 450) ? 2 : 3;
		animation.add(char, [0, 1, 2].slice(0, frameCount), 0, false, isPlayer); 
		animation.play(char);
		this.char = char;

		if(char.endsWith('-pixel'))
			antialiasing = false;
		else
			antialiasing = ClientPrefs.data.antialiasing;
	}
}

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String {
		return char;
	}
}