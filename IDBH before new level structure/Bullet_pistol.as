package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	import flash.geom.Point;
	
	public class Bullet_pistol extends MovieClip {
		
		public var pace: Point = new Point(0,0);
		public var level: Level;
		
		public var damage: int;
		private var lifetime: int;
		public var death: Boolean = false;
		
		public var r: int = 1;

		public function Bullet_pistol(where:Level, X: int, Y: int, rotationInDegrees: Number, life:int, theDamage:int = 3, theSpeed:Number = 10): void {
			
			rotation = rotationInDegrees;
			var rotationRequired : Number = (rotationInDegrees - 90) * Math.PI / 180;
			pace.x = Math.cos(rotationRequired)*theSpeed;
			pace.y = Math.sin(rotationRequired)*theSpeed;
			x = X + Math.cos(rotationRequired)*20;
			y = Y + Math.sin(rotationRequired)*20;
			lifetime = life;
			level = where;
			damage = theDamage;
		}
		
		
		public function loop(): void {
			x += pace.x;
			y += pace.y;
			rotation = Math.atan2(pace.x, -pace.y) * 180 / Math.PI;
			
			var point:Point = level.localToGlobal(new Point(x, y));
			if (level.walls.hitTestPoint(point.x, point.y, true))
				death = true;
			
			for (var j:int = level.unitList.length - 1; j >= 0; --j)
				if (level.unitList[j].hitTestPoint(point.x, point.y, true)) {
					level.unitList[j].onHit(damage);
					death = true;
					break;
				}
				
			--lifetime;
			if (lifetime <= 0)
				death = true;
			
		}
		public function destroy(): void {
			var explosion_basic:Explosion_basic = new Explosion_basic(x, y);
			level.addChild(explosion_basic);
			level.removeChild(this);
		}
	}
}