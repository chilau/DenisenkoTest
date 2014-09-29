package com.torikos.controller
{
	import com.torikos.controller.events.DraggableGUIComponentEvent;
	import com.torikos.controller.events.WeakGUIContainerEvent;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * Контроллер контейнера, способного терять находящиеся на нем объекты,
	 * если их утянут с него мышью
	 */
	public class WeakGUIContainer extends GUIContainer
	{
		/**
		 * Кондатат на потерю при перемещении мышью за пределы контейнера
		 */
		private var _lostCondidate:GUIComponent;
		
		/**
		 * Конструктор
		 */
		public function WeakGUIContainer(target:IEventDispatcher=null)
		{
			_lostCondidate = null;
			
			super(target);
		}
		
		/**
		 * Обработчик события высвобождения объекта после перетаскивания
		 */
		protected override function onChildReleased(event:DraggableGUIComponentEvent):void
		{
			var child:GUIComponent = event.target as GUIComponent;
			if (child == null)
			{
				return;
			}
			
			if (model == null)
			{
				return;
			}
			
			var mouseX:int = event.localX + child.model.x;
			var mouseY:int = event.localY + child.model.y;
			
			if (mouseX < 0 || mouseX > model.width || mouseY < 0 + 20 || mouseY > model.height)
			{
				_lostCondidate = child;
				
				var childLostEvent:WeakGUIContainerEvent = new WeakGUIContainerEvent(WeakGUIContainerEvent.CHILD_LOST);
				childLostEvent.localX = mouseX + model.x;
				childLostEvent.localY = mouseY + model.y;
				childLostEvent.lostCondidate = child;
				dispatchEvent(childLostEvent);
			}
			else
			{
				super.onChildReleased(event);
			}
		}
		
		/**
		 * Вернуть объект на место
		 */
		public function returnObject(lostCondidate:GUIComponent):void
		{
			returnChild(lostCondidate);
		}
		
		/**
		 * Удалить объект с контейнера
		 */
		public function removeObject(lostCondidate:GUIComponent):void
		{
			lostCondidate.removeAllEventListeners();
			_childs.removeChild(lostCondidate);
		}
	}
}