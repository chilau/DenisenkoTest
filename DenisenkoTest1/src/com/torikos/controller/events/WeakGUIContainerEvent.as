package com.torikos.controller.events
{
	import com.torikos.controller.GUIComponent;
	
	import flash.events.Event;
	
	/**
	 * Событие, генерируемое контейнером способного терять находящиеся на нем объекты,
	 * если их утянут с него мышью
	 */
	public class WeakGUIContainerEvent extends Event
	{
		/**
		 * Потомок покинул пределы контейнера
		 */
		public static var CHILD_LOST:String = "ChildLost";
		
		/**
		 * Координата по оси X
		 */
		public var localX:int;
		/**
		 * Коорданата по оси Y
		 */
		public var localY:int;
		
		/**
		 * Объект, который может покинуть контейнер по средствам перетаскивания мышью
		 */
		public var lostCondidate:GUIComponent;
		
		/**
		 * Конструктор
		 */
		public function WeakGUIContainerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}