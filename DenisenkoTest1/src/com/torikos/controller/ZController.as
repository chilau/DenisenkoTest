package com.torikos.controller
{
	import com.torikos.controller.events.DraggableGUIComponentEvent;
	import com.torikos.events.AdvancedEventDispatcher;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * Контроллер отвечающий за хранение и Z сортировку графических объектов
	 */
	public class ZController extends AdvancedEventDispatcher
	{
		/**
		 * Все отображаемые графические элементы
		 */
		private var _childs:Vector.<GUIComponent>;
		
		/**
		 * Конструктор
		 */
		public function ZController(target:IEventDispatcher=null)
		{
			super(target);
			
			_childs = new Vector.<GUIComponent>();
		}
		
		/**
		 * Добавить объект на форму
		 */
		public function addChild(container:GUIComponent):void
		{
			if (_childs.indexOf(container) != -1)
			{
				return;
			}
			
			_childs.push(container);
			
			container.addEventListener(DraggableGUIComponentEvent.CLICK, onChildClick);
			container.model.z = Number.MAX_VALUE;
			sortObjectByZPosition();
		}
		
		/**
		 * Удалить объект с формы
		 */
		public function removeChild(container:GUIComponent):void
		{
			if (_childs.indexOf(container) == -1)
			{
				return;
			}
			
			container.removeAllEventListeners();
			_childs.splice(_childs.indexOf(container), 1);
			
			sortObjectByZPosition();
		}
		
		/**
		 * Обработчик события нажатия мышью по окну
		 */
		private function onChildClick(event:DraggableGUIComponentEvent):void
		{
			if (!event.canMoveParent || event.shiftPressed)
			{
				var target:GUIComponent = event.target as GUIComponent;
				if (target == null)
				{
					return;
				}
				
				target.model.z = int.MAX_VALUE;
			}
			
			sortObjectByZPosition();
		}
		
		/**
		 * Выстроить все элементы согласно Z индекса
		 */
		private function sortObjectByZPosition():void
		{
			if (_childs == null || _childs.length == 0)
			{
				return;
			}
			
			_childs = _childs.sort(compareZ);
			
			var currentZ:int = 0;
			for (var i:int = 0; i < _childs.length; i++)
			{
				var container:GUIComponent = _childs[i];
				container.model.z = currentZ++;
				container.model.isActive = false;
			}
			
			var lastContainer:GUIComponent = _childs[_childs.length - 1];
			lastContainer.model.isActive = true;
		}
		
		/**
		 * Метод сортировки массива графических элементов по координате Z
		 */
		private function compareZ(x:GUIComponent, y:GUIComponent):Number
		{
			if (x.model.z < y.model.z)
			{
				return -1;
			}
			
			if (x.model.z > y.model.z)
			{
				return 1;
			}
			
			return 0;
		}
		
		/**
		 * Количество хранящихся элементов
		 */
		public function length():int
		{
			return _childs.length;
		}
		
		/**
		 * Получить элемент по индексу
		 */
		public function getItemByIndex(index:int):GUIComponent
		{
			return _childs[index];
		}
		
		/**
		 * Все отображаемые графические элементы
		 */
		public function get childs():Vector.<GUIComponent>
		{
			return _childs;
		}
	}
}