package com.torikos.controller
{
	import com.torikos.model.BaseGUIModel;
	import com.torikos.model.CircleModel;
	import com.torikos.view.CircleView;
	import com.torikos.view.RectangleView;
	import com.torikos.view.TriangleView;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * Контроллер окна
	 */
	public class Window extends WeakGUIContainer
	{
		/**
		 * Конструктор
		 */
		public function Window(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * Добавить прямоугольник на форму
		 */
		public function addRectangleToWindow(x:int, y:int, z:int, width:int, height:int, color:uint):void
		{
			var rectangleModel:BaseGUIModel = new BaseGUIModel();
			rectangleModel.setParams(x, y, z, width, height, color);
			
			var rectangleView:RectangleView = new RectangleView(rectangleModel);
			
			var rectangleContainer:PrimitiveGUIComponent = new PrimitiveGUIComponent();
			rectangleContainer.model = rectangleModel;
			rectangleContainer.view = rectangleView;
			
			addChild(rectangleContainer);
		}
		
		/**
		 * Добавить окружность на форму
		 */
		public function addCircleToWindow(x:int, y:int, z:int, radius:int, color:uint):void
		{
			var circleModel:CircleModel = new CircleModel();
			circleModel.setCircleParams(x, y, z, radius, color);
			
			var circleView:CircleView = new CircleView(circleModel);
			
			var circleContainer:PrimitiveGUIComponent = new PrimitiveGUIComponent();
			circleContainer.model = circleModel;
			circleContainer.view = circleView;
			
			addChild(circleContainer);
		}
		
		/**
		 * Добавить треугольник на форму
		 */
		public function addTriangleToWindow(x:int, y:int, z:int, width:int, height:int, color:uint):void
		{
			var triangleModel:BaseGUIModel = new BaseGUIModel();
			triangleModel.setParams(x, y, z, width, height, color);
			
			var triangleView:TriangleView = new TriangleView(triangleModel);
			
			var circleContainer:PrimitiveGUIComponent = new PrimitiveGUIComponent();
			circleContainer.model = triangleModel;
			circleContainer.view = triangleView;
			
			addChild(circleContainer);
		}
	}
}