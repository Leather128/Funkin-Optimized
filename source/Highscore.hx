package;

import flixel.FlxG;

class Highscore {
	public static var difficultyArray:Array<String> = ['EASY', 'NORMAL', 'HARD'];
	public static var difficultyString(get, null):String;

	private static function get_difficultyString():String {
		return difficultyArray[PlayState.storyDifficulty];
	}

	public static var songScores:Map<String, Int> = new Map();

	public static function saveScore(song:String, score:Int = 0, ?diff:Int = 0):Void {
		var daSong:String = formatSong(song, diff);

		if (songScores.exists(daSong)) {
			if (songScores.get(daSong) < score)
				setScore(daSong, score);
		} else
			setScore(daSong, score);
	}

	public static function saveWeekScore(week:Int = 1, score:Int = 0, ?diff:Int = 0):Void {
		var daWeek:String = formatSong('week${week}', diff);

		if (songScores.exists(daWeek)) {
			if (songScores.get(daWeek) < score)
				setScore(daWeek, score);
		} else
			setScore(daWeek, score);
	}

	/**
	 * YOU SHOULD FORMAT SONG WITH formatSong() BEFORE TOSSING IN SONG VARIABLE
	 */
	static function setScore(song:String, score:Int):Void {
		// Reminder that I don't need to format this song, it should come formatted!
		songScores.set(song, score);
		FlxG.save.data.songScores = songScores;
		FlxG.save.flush();
	}

	public static function formatSong(song:String, diff:Int):String {
		var daSong:String = song;

		if (diff == 0)
			daSong += '-easy';
		else if (diff == 2)
			daSong += '-hard';

		return daSong;
	}

	public static function getScore(song:String, diff:Int):Int {
		if (!songScores.exists(formatSong(song, diff)))
			setScore(formatSong(song, diff), 0);

		return songScores.get(formatSong(song, diff));
	}

	public static function getWeekScore(week:Int, diff:Int):Int {
		if (!songScores.exists(formatSong('week' + week, diff)))
			setScore(formatSong('week' + week, diff), 0);

		return songScores.get(formatSong('week' + week, diff));
	}

	public static function load():Void {
		if (FlxG.save.data.songScores != null) {
			songScores = FlxG.save.data.songScores;
		}
	}
}
