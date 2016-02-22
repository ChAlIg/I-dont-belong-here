package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	import flash.geom.Point;
	
	public class Bullet extends MovieClip {
		
		public var game: Game;
		
		public var pace: int;
		public var step: Point = new Point(0,0);
		public var destination: Point;
		
		public var damage: int;
		public var death: Boolean = false;
		public var lifetimemax: int;
		public var lifetime: int;
		
		var i: int = 0;
		var j: int;
		var point:Point;
		var point2:Point;

		public function Bullet(main: Game, X: int, Y: int, destX: int, destY: int, theDamage:int = 3, theSpeed:Number = 30): void {
			
			game = main;
			destination = new Point(destX, destY);
			
			rotation = Math.atan2(destY-Y, destX-X)*180/Math.PI;
			var rotationRequired : Number = rotation * Math.PI / 180;
			step.x = Math.cos(rotationRequired)*5;
			step.y = Math.sin(rotationRequired)*5;
			pace = theSpeed/5;
			x = X + Math.cos(rotationRequired)*40;
			y = Y + Math.sin(rotationRequired)*40;
			damage = theDamage;
			lifetimemax = Math.sqrt((destX-x)*(destX-x) + (destY-y)*(destY-y))/5;
			lifetime = lifetimemax;
			trace (destX-x);
			trace (destY-y);
			trace (step.x);
			trace(step.y);
			trace (lifetime);
		}
		
		public function loop(): void {
			
			point = new Point (x, y);
			for (i = 0; i < pace; ++i) {
				--lifetime;
				point.x += step.x;
				point.y += step.y;
				
				point2 = game.level.localToGlobal(new Point(x, y));
				if (game.level.walls.hitTestPoint(point2.x, point2.y, true)){
					death = true;
				}
			
				for (j = game.level.common.unitList.length - 1; j >= 0; --j) {
					if (game.level.common.unitList[j].hitTestPoint(point2.x, point2.y, true)) {
						if (Math.random() > Number(lifetime/lifetimemax)) {
							game.level.common.unitList[j].onHit(damage);
							death = true;
							break;
						}
					}
				}
				
				if (death)
					break;
				
				if (lifetime <= 0) {
					for (j = game.level.common.unitList.length - 1; j >= 0; --j) {
						if (game.level.common.unitList[j].hitTestPoint(destination.x, destination.y, true)) {
							game.level.common.unitList[j].onHit(damage);
							death = true;
							break;
						}
					}
					death = true;
				}
				
				if (death)
					break;
			}
			x = point.x;
			y = point.y;
		}
		public function destroy(): void {
			var explosion_basic:Explosion_basic = new Explosion_basic(x, y);
			game.level.layerList[3].addChild(explosion_basic);
			game.level.common.removeChild(this);
		}
	}
}
