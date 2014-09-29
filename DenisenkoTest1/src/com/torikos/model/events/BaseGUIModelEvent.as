package com.torikos.model.events
{
	import flash.events.Event;
	
	/**
	 * Событие, гереритуемое моделями графических компонентов
	 */
	public class BaseGUIModelEvent extends Event
	{
		/**
		 * Цвет прямоугольника был измененн
		 */
		public static var COLOR_CHANGED:String = 'ColorChanged';
		/**
		 * Размер графического объекта был изменен
		 */
		public static var SIZE_CHANGED:String = "SizeChanged";
		/**
		 * Позиция графического объекта была изменен
		 */
		public static var POSITION_CHANGED:String = "PositionChanged";
		/**
		 * Позиция графического объекта по оси Z была изменен
		 */
		public static var Z_POSITION_CHANGED:String = "ZPositionChanged";
		/**
		 * Признак активности изменился
		 */
		public static var ACTIVE_CHANGED:String = 'ActiveChanged';
		
		/**
		 * Конструктор
		 */
		public function BaseGUIModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}