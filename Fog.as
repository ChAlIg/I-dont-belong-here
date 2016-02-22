package  {
	import flash.display.MovieClip;
	
	public class Fog extends MovieClip {
		public var game: Game;
		public var death: Boolean = false;
		public var fog_invisible: Fog_invisible;
		public var fog_shade: Fog_shade;
		public var fog_mask: Fog_mask;
		public var fog_obscure: Fog_obscure;

		public function Fog(main:Game) {
			game = main;
			fog_invisible = new Fog_invisible();
			fog_shade = new Fog_shade();
			fog_mask = new Fog_mask();
			fog_obscure = new Fog_obscure();
			addChild(fog_invisible);
			addChild(fog_mask);
			addChild(fog_shade);
			addChild(fog_obscure);
			fog_invisible.mask = fog_mask;
		}
		public function loop(): void {
			fog_invisible.x = game.level.player1.x;
			fog_mask.x = game.level.player1.x;
			fog_shade.x = game.level.player1.x;
			fog_invisible.y = game.level.player1.y;
			fog_mask.y = game.level.player1.y;
			fog_shade.y = game.level.player1.y;
			fog_invisible.rotation = game.level.player1.rotation;
			fog_mask.rotation = game.level.player1.rotation;
			fog_shade.rotation = game.level.player1.rotation;
		}

	}
	
}
