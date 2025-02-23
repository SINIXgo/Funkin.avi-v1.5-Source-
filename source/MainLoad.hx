
package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.system.FlxSound;
import lime.app.Application;
#if windows
import Discord.DiscordClient;
#end
import openfl.display.BitmapData;
import openfl.utils.Assets;
import haxe.Exception; //funi
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
#if cpp
import sys.FileSystem;
import sys.io.File;
import sys.thread.Thread;
#end

using StringTools;

class MainLoad extends MusicBeatState
{

	var text:FlxText;

	public static var bitmapData:Map<String, FlxGraphic>;
	public static var bitmapData2:Map<String, FlxGraphic>;

	var images = [];
	var music = [];
	var charts = [];

	override function create()
	{
		FlxG.mouse.visible = true;

		FlxG.worldBounds.set(0,0);

		bitmapData = new Map<String,FlxGraphic>();
		bitmapData2 = new Map<String,FlxGraphic>();

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('funkay')); //Placeholder
		menuBG.screenCenter();
		add(menuBG);

		text = new FlxText(FlxG.width / 2, FlxG.height / 2 + 300, 0, "Loading...");
		text.size = 34;
		text.alignment = FlxTextAlign.CENTER;
		text.alpha = 0;
		add(text);
              
		#if sys 
		//Splash Cache lol	
		for (i in HSys.readDirectory("assets/shared/images/NoteSplashSkins"))
		{
			if (!i.endsWith(".png"))
				continue;
			images.push(i);
		}
                //Songs Cache Lol²
		for (i in HSys.readDirectory("assets/songs"))
		{
			music.push(i);
		}
		#end

		sys.thread.Thread.create(() -> {
			cache();
		});

		super.create();
	}


	override function update(elapsed) 
	{
		super.update(elapsed);
	}

	function cache()
	{
		#if !linux

		for (i in images)
		{
			var replaced = i.replace(".png","");
			var data:BitmapData = BitmapData.fromFile("assets/shared/images/NoteSplashSkins");
			var graph = FlxGraphic.fromBitmapData(data);
			graph.persist = true;
			graph.destroyOnNoUse = false;
			bitmapData.set(replaced,graph);
			trace(i);
		}



		for (i in music)
		{
			trace(i);
		}


		#end
        if(ClientPrefs.language == null) { //null because there's no selection when a new data starts, btw i tested it and works
			MusicBeatState.switchState(new LanguageState());
		} else {
		if(ClientPrefs.language == "Spanish") {
			MusicBeatState.switchState(new SpanishTitleState());
		} else {
		MusicBeatState.switchState(new TitleState());
	}
	}
	}
	}
