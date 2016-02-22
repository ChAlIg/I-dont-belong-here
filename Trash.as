package {
	import flash.display.MovieClip;
	import flash.geom.Transform; 
	import flash.geom.ColorTransform; 

	public class Trash extends MovieClip {
		
		public var game: Game;
		public var usualColour: ColorTransform = new ColorTransform ();
		public var hitTimer: int = 0;
		public var redOnHit: ColorTransform = new ColorTransform (2.5);
		
		public var death: Boolean = false;
		public var health: int = 10;
		
		public var r: int = 8;
		
		public function Trash(main: Game, X: int, Y: int): void {
			this.x = X;
			this.y = Y;
			game = main;
		}
		public function loop(): void {
			if (hitTimer == 1) {
				--hitTimer;
				this.transform.colorTransform = usualColour;
			} else if (hitTimer) {
				--hitTimer
				this.transform.colorTransform = redOnHit;
			}
			if (health <= 0) {
				death = true;
			}
		}
		public function onHit(damage: int): void {
			
			health -= damage;
			var pale_1: Pale_1 = new Pale_1 (game, x, y);
			game.level.common.unitList.push(pale_1);
			game.level.common.addChild (pale_1);
			var bullet_pistol: Bullet_pistol;
			var j:int = (Math.random()*60);
			for (var i:int = 0; i < 6; ++i) {
				bullet_pistol = new Bullet_pistol(game, x, y, j + i*60, 20);
				game.level.common.bulletList.push(bullet_pistol);
				game.level.common.addChild(bullet_pistol);
			}
			hitTimer = 5;
		}
		public function destroy(): void {
			var explosion_basic:Explosion_basic = new Explosion_basic(x, y, 5);
			game.level.layerList[3].addChild(explosion_basic);
			game.level.common.removeChild(this);
		}
	}
}