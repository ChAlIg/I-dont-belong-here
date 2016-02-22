package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	import flash.geom.Point;
	
	public class Bullet_pistol extends MovieClip {
		
		public var game: Game;
		
		public var pace: Point = new Point(0,0);
		
		public var damage: int;
		private var lifetime: int;
		public var death: Boolean = false;
		
		public var r: int = 1;

		public function Bullet_pistol(main: Game, X: int, Y: int, rotationInDegrees: Number, life:int, theDamage:int = 3, theSpeed:Number = 20): void {
			
			game = main;
			
			rotation = rotationInDegrees;
			var rotationRequired : Number = (rotationInDegrees - 90) * Math.PI / 180;
			pace.x = Math.cos(rotationRequired)*theSpeed;
			pace.y = Math.sin(rotationRequired)*theSpeed;
			x = X + Math.cos(rotationRequired)*20;
			y = Y + Math.sin(rotationRequired)*20;
			lifetime = life;
			damage = theDamage;
		}
		
		public function loop(): void {
			x += pace.x;
			y += pace.y;
			rotation = Math.atan2(pace.x, -pace.y) * 180 / Math.PI;
			
			var point:Point = game.level.localToGlobal(new Point(x, y));
			if (game.level.walls.hitTestPoint(point.x, point.y, true))
				death = true;
			
			for (var j:int = game.level.common.unitList.length - 1; j >= 0; --j)
				if (game.level.common.unitList[j].hitTestPoint(point.x, point.y, true)) {
					game.level.common.unitList[j].onHit(damage);
					death = true;
					break;
				}
				
			--lifetime;
			if (lifetime <= 0)
				death = true;
			
		}
		public function destroy(): void {
			var explosion_basic:Explosion_basic = new Explosion_basic(x, y);
			game.level.layerList[3].addChild(explosion_basic);
			game.level.common.removeChild(this);
		}
	}
}

