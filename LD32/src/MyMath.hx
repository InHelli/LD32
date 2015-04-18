package ;

/**
 * ...
 * @author InHelli
 */
class MyMath
{

	//---------------------------------------
		// PUBLIC METHODS
		//---------------------------------------
		
		/**
		 * Рассчитывает дистанцию между двумя точками.
		 * 
		 * @param x1, y1 - координаты первой точки.
		 * @param x2, y2 - коордианты второй точки.
		 * 
		 * @return дистанция.
		 */
		public static function distance(x1:Float, y1:Float, x2:Float, y2:Float):Float
		{
			var dx:Float = x2 - x1;
			var dy:Float = y2 - y1;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		/**
		 * Возвращает случайное число в диапазоне от lower до upper.
		 * 
		 * @param lower - наименьшее число диапазона.
		 * @param upper - наибольшее число диапазона.
		 * 
		 * @return случайное целое число.
		 */
		public static function random(lower:Float, upper:Float):Float
		{
			return Math.round(Math.random() * (upper - lower)) + lower;
		}
		
		/**
		 * Сравнивает два значения с заданной погрешностью.
		 * 
		 * @param a, b - сравниваемые значения.
		 * @param diff - допустимая погрешность.
		 * 
		 * @return возвращает true если значения равны, или false если не равны.
		 */
		public static function equal(a:Float, b:Float, diff:Float = 0.00001):Bool
		{
			return (Math.abs(a - b) <= diff);
		}
		
		/**
		 * Возвращает угол между двумя точками радианах.
		 * 
		 * @param x1, y1 - координаты первой точки.
		 * @param x2, y2 - координаты второй точки.
		 * 
		 * @return угол между двумя точками в радианах.
		 */
		public static function getAngle(x1:Float, y1:Float, x2:Float, y2:Float, norm:Bool = true):Float
		{
			var dx:Float = x2 - x1;
			var dy:Float = y2 - y1;
			var angle:Float = Math.atan2(dy, dx);
			
			if (norm)
			{
				if (angle < 0)
				{
					angle = Math.PI * 2 + angle;
				}
				else if (angle >= Math.PI * 2)
				{
					angle = angle - Math.PI * 2;
				}
			}
			
			return angle;
		}
		
		/**
		 * Возвращает угол между двумя точками в градусах.
		 * 
		 * @param x1, y1 - координаты первой точки.
		 * @param x2, y2 - координаты второй точки.
		 * 
		 * @return угол между двумя точками в градусах.
		 */
		public static function getAngleDeg(x1:Float, y1:Float, x2:Float, y2:Float, norm:Bool = true):Float
		{
			var dx:Float = x2 - x1;
			var dy:Float = y2 - y1;
			var angle:Float = Math.atan2(dy, dx) / Math.PI * 180;
			
			if (norm)
			{
				if (angle < 0)
				{
					angle = 360 + angle;
				}
				else if (angle >= 360)
				{
					angle = angle - 360;
				}
			}
			
			return angle;
		}
		
		/**
		 * Переводит угол из радиан в градусы.
		 * 
		 * @param radians - угол в радианах.
		 * 
		 * @return угол в градусах.
		 */
		public static function toDegrees(radians:Float):Float
		{
			return radians * 180 / Math.PI;
		}
		
		/**
		 * Переводит угол из градусов в радианы.
		 * 
		 * @param degrees - угол в градусах.
		 * 
		 * @return угол в радианах.
		 */
		public static function toRadians(degrees:Float):Float
		{
			return degrees * Math.PI / 180;
		}
		
		/**
		 * Возвращает процент значения current от общего значения total.
		 * 
		 * @param current - текущее значение.
		 * @param total - общее значение.
		 * 
		 * @return percent.
		 */
		public static function toPercent(current:Float, total:Float):Float
		{
			return (current / total) ;
		}
		
		/**
		 * Возвращает текущее значене исходя из процентного соотношения к общему числу.
		 * 
		 * @param percent - текущий процент.
		 * @param total - общее значение.
		 * 
		 * @return возвращает текущее значение.
		 */
		public static function fromPercent(percent:Float, total:Float):Float
		{
			return (percent * total) / 100;
		}
		
		public static  function toPix(value:Float):Float
		{
			return value * 32;
		}
		
		public static  function toTitle(value:Float):Int
		{
			return Math.round((value-16) / 32);
		}
		/**
		 * 
		 * 
		 */
		public static function betweenAnglesDeg(a:Float, b:Float):Float
		{
			var angle:Float = Math.abs(a - b);
			if (angle > 180) angle = 360 - angle;
			return angle;
		}
}