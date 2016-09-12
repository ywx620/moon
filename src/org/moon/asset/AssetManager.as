package org.moon.asset
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.net.LocalConnection;
	import flash.utils.Dictionary;

	/**
	 * ...2016-7-15
	 * @author vinson
	 * 资源管理,可以同时加载xml,swf,jpg,png,gif,mp3等格式
	 * as3不支持wav,解决办法1是把wav转成mp3,2是把wav导入到fla中
	 * 计划再加入加载FLV格式
	 */
	public class AssetManager
	{
		private static var instaner:AssetManager;
		public var data:Object={};
		public var assets:Dictionary=new Dictionary;
		public var assetUrls:Dictionary=new Dictionary;
		public static var ID:int=0;
		public static const SWF:String="swf";
		public static const PIC:String="pic";
		public static const SOUND:String="sound";
		public static const XML:String="xml";
		public static const FLV:String="flv";
		public static function getIns():AssetManager
		{
			if(instaner==null) instaner=new AssetManager
			return instaner;
		}
		/**不加载,只是把名字与地址存下来*/
		public function addAsset(assetName:String,url:String):void
		{
			assetUrls[assetName]=url;
		}
		public function getUrlByAssetName(assetName:String):String
		{
			return assetUrls[assetName];
		}
		/**此方法马上加载*/
		public function loadAsset(url:String,onCompleteFunc:Function=null,onProgressFunc:Function=null,assetName:String=""):Boolean
		{ 
			var name:String=url;
			if(assetName!=""){
				name=assetName;
			}
			if(assets[name]==null){
				var ass:AssetItem = new AssetItem();
				ass.id = ID++;
				ass.type = getTypeByUrl(url);
				ass.url = url;
				ass.onCompleteFunc = onCompleteFunc;
				ass.onProgressFunc = onProgressFunc;
				ass.start();
				ass.backComplete=function backComplete():void{
					assets[name]=ass;
				}
				return false;
			}else{
				//trace("已经加载过了,可以直接使用此资源");
				return true;
			}
		}
		public function removeAsset(assetName:String):void
		{
			if(assets[assetName]!=null){
				var ass:AssetItem = assets[assetName];
				ass.dispose();
				ass=null;
				delete assets[assetName];
				doClear();
			}
		}
		private var conn1:LocalConnection;
		private var conn2:LocalConnection;
		/**强制执行垃圾回收*/
		private function doClear( ):void {
			try{
				conn1 = new LocalConnection();
				conn1.connect('foo');
				conn2 = new LocalConnection();
				conn2.connect('foo');
			}catch(e :*){
				trace("垃圾回收出错");
			}
			finally{
				conn1 = null;
				conn2 = null;
			}
		}
		private function getTypeByUrl(url:String):String
		{
			var arr:Array=url.split(".");
			var type:String=arr[arr.length-1];
			switch(type){
				case "mp3":
					type=SOUND;
					break;
				case "swf":
					type=SWF;
					break;
				case "jpg":
				case "png":
				case "gif":
					type=PIC;
					break;
				case "xml":
				case "txt":
					type=XML;
					break;
				case "flv":
					type=FLV;
					break;
			}
			return type;
		}
		public function hasAssetItem(assetName:String):Boolean
		{
			return assets[assetName];
		}
		/**得到外部加载的图片*/
		public function getPic(assetName:String):Bitmap
		{
			var ass:AssetItem=assets[assetName];
			return ass.bitmap
		}
		/**得到外部加载的图片*/
		public function getData(assetName:String):Object
		{
			var ass:AssetItem=assets[assetName];
			return ass.data
		}
		/**得到外部加载的图片*/
		public function getSound(assetName:String):Sound
		{
			var ass:AssetItem=assets[assetName];
			return ass.sound;
		}
		/**得到外部加载的FLV数据 {ns:NetConnection,ns:NetStream,vid:Video}*/
		public function getFlv(assetName:String):Object
		{
			var ass:AssetItem=assets[assetName];
			return ass.flvManager;
		}
		/**得到外部加载swf场景中的所有对象*/
		public function getSwf(assetName:String):MovieClip
		{
			var ass:AssetItem=assets[assetName];
			return ass.loaderInfo.content as MovieClip; 
		}
		/**得到外部加载swf中库链接的对象*/
		public function getSwfClass(assetName:String,linkage:String):Class
		{
			var ass:AssetItem=assets[assetName];
			if(ass&&ass.loaderInfo.applicationDomain.hasDefinition(linkage)){
				var c:Class=ass.loaderInfo.applicationDomain.getDefinition(linkage) as Class;
				return c;
			}
			return null; 
		}
		/**得到外部加载swf中库链接的影片*/
		public function getSwfMovieClip(assetName:String,linkage:String):MovieClip
		{
			var c:Class=getSwfClass(assetName,linkage);
			return new c;
		}
		/**得到外部加载swf中库链接的图片*/
		public function getSwfBitmap(assetName:String,linkage:String):Bitmap
		{
			var c:Class=getSwfClass(assetName,linkage);
			var b:Bitmap=new Bitmap(new c);
			return b;
		}
		/**得到外部加载swf中库链接的声音*/
		public function getSwfSound(assetName:String,linkage:String):Sound
		{
			var c:Class=getSwfClass(assetName,linkage);
			return new c;
		}
	}
}
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.NetStatusEvent;
import flash.events.ProgressEvent;
import flash.media.Sound;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;
import flash.net.URLLoader;
import flash.net.URLRequest;

import utils.AssetManager;

class AssetItem extends Object
{
	public var type:String;
	public var id:int;
	public var url:String;
	public var onCompleteFunc:Function;
	public var onProgressFunc:Function;
	public var loaderInfo:LoaderInfo;
	private var _bitmap:Bitmap;
	public var xml:XML;
	public var sound:Sound;
	public var urlLoader:URLLoader;
	public var loader:Loader;
	public var flvManager:Object;
	public var data:Object
	public var backComplete:Function;
	public function AssetItem(){
		
	}
	public function start():void
	{
		if(type==AssetManager.XML){//文本数据
			urlLoader = new URLLoader();
			urlLoader.load(new URLRequest(url));
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			urlLoader.addEventListener(ProgressEvent.PROGRESS, onLoadProgress); 
			urlLoader.addEventListener(Event.COMPLETE, onLoaderComplete);
		}else if(type==AssetManager.SOUND){//声音数据
			sound=new Sound();
			sound.load(new URLRequest(url));
			sound.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			sound.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			sound.addEventListener(Event.COMPLETE, onLoaderComplete);
		}else if(type==AssetManager.FLV){//FLV数据
			var nc:NetConnection=new NetConnection(); 
			nc.connect (null);
			var ns:NetStream=new NetStream(nc); 
			ns.play (url); 
			var onMetaData:Object = new Object();
			ns.client = onMetaData;
			var vid:Video=new Video(); 
			vid.attachNetStream(ns);
			ns.addEventListener(NetStatusEvent.NET_STATUS,onStatus);
			flvManager={nc:nc,ns:ns,vid:vid};
		}else{//swf和图片数据
			loader=new Loader();
			loader.load(new URLRequest(url));
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
		}
		
	}
	private function onIoError(e:IOErrorEvent):void 
	{
		trace("onIoError: " ,url);
	}
	private function onLoadProgress(e:ProgressEvent):void 
	{
		var percent:int=int(e.bytesLoaded / e.bytesTotal*100);
		//trace("load..."+percent);
		if(this.onProgressFunc){
			this.onProgressFunc(percent);
		}
	}
	private function onLoaderComplete(e:Event):void
	{
		if(type==AssetManager.XML){
			data=urlLoader.data;
		}else if(type==AssetManager.SOUND){
			
		}else{	
			loaderInfo=loader.contentLoaderInfo;
			if(type==AssetManager.PIC){
				_bitmap=loaderInfo.content as Bitmap;
			}
		}
		this.backComplete();
		if(this.onCompleteFunc){
			this.onCompleteFunc(this);
		}
		removeLoadEvent();
	}
	private function onStatus(_evt:NetStatusEvent ):void {
		if (_evt.info.code=="NetStream.Buffer.Full") {
			if(this.onCompleteFunc){
				this.onCompleteFunc(this);
			}
			removeLoadEvent();
		}
	}
	
	private function removeLoadEvent():void
	{
		if(urlLoader!=null){
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
			urlLoader.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress); 
			urlLoader.removeEventListener(Event.COMPLETE, onLoaderComplete);
			urlLoader=null;
		}
		if(loader!=null){
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete);
			loader=null;
		}
		if(sound!=null){
			sound.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
			sound.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			sound.removeEventListener(Event.COMPLETE, onLoaderComplete);
		}
		if(flvManager){
			flvManager.ns.removeEventListener(NetStatusEvent.NET_STATUS,onStatus);
		}
		
	}
	public function dispose():void
	{
		type=null;
		url=null;
		onCompleteFunc=null;
		onProgressFunc=null;
		loaderInfo=null;
		_bitmap=null;
		xml=null;
		sound=null;
		urlLoader=null;
		loader=null;
		flvManager=null;
		data=null;
	}

	public function get bitmap():Bitmap
	{
		var bd:BitmapData=new BitmapData(_bitmap.width,_bitmap.height,true,0x00000000);
		bd.draw(_bitmap);
		var b:Bitmap=new Bitmap(bd);
		return b;
	}
}