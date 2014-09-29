package com.torikos.controller.events
{
	import flash.events.Event;
	
	/**
	 * Событие, генерируемое перетаскиваемым объектом
	 */
	public class DraggableGUIComponentEvent extends Event
	{
		/**
		 * Объект сдвинут
		 */
		public static var MOVED:String = 'Moved';
		/**
		 * На объекте нажали кнопкой мыши
		 */
		public static var CLICK:String = 'Click';
		/**
		 * Перетаскивание объекта завершено
		 */
		public static var RELEASED:String = 'Released';
		
		/**
		 * Новая координата X
		 */
		public var xPos:int;
		
		/**
		 * Новая координата Y
		 */
		public var yPos:int;
		
		/**
		 * Координата по оси X
		 */
		public var localX:int;
		/**
		 * Коорданата по оси Y
		 */
		public var localY:int;
		
		/**
		 * Зажата пнопка Shift
		 */
		public var shiftPressed:Boolean = false;
		
		/**
		 * Может стать инициировать перемещение предка
		 */
		public var canMoveParent:Boolean = false;
		
		/**
		 * Конструктор
		 */
		public function DraggableGUIComponentEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}