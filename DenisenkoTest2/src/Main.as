package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Main extends Sprite
	{
		/**
		 * Регулярное выражение, описывающее символы, которые следует считать разделителями между слов
		 */
		private const _spacerRegExp:RegExp = /[.,:; ()''""<>\/>\n\r]/;
		
		/**
		 * Имя файла из которого будет браться текст для подсчета слов
		 */
		private const _fileName:String = "tmp.txt";
		
		public function Main()
		{
			var textLoader:URLLoader = new URLLoader();
			textLoader.addEventListener(Event.COMPLETE, onLoaded);
			textLoader.load(new URLRequest(_fileName));
		}
		
		/**
		 * Обработчик события окончания загрузки содержимого файла
		 */
		private function onLoaded(event:Event):void
		{
			if (event.target != null && event.target is IEventDispatcher)
			{
				(event.target as IEventDispatcher).removeEventListener(Event.COMPLETE, onLoaded);
			}
			
			var words:Array = event.target.data.toLowerCase().split(_spacerRegExp);
			countWords(words);
		}
		
		/**
		 * Подсчитать колечество слов
		 */
		private function countWords(words:Array):void
		{
			words.sort();
			
			var index:int = 0;
			var count:int = 1;
			while(index < words.length)
			{
				count = 1;
				while(index < words.length+1 && words[index] == words[index+1])
				{
					count++;
					index++;
				}
				
				trace(words[index] + " - " + count);
				
				index++;
			}
		}
	}
}