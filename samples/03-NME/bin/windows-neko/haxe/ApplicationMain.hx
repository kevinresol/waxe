// Might have waxe without NME
#if nme
import nme.Assets;
#elseif waxe
import wx.Assets;
#end

#if cpp

#end



#if iosview
@:buildXml("
<files id='__lib__'>
  <file name='FrameworkInterface.mm'>
  </file>
</files>
")
#end

class ApplicationMain
{

   #if waxe
   static public var frame : wx.Frame;
   static public var autoShowFrame : Bool = true;
   #if nme
   static public var nmeStage : wx.NMEStage;
   #end
   #end
   
   public static function main()
   {
      #if cpp
      
      #end

      #if flash

      nme.AssetData.create();

      #elseif nme
      nme.Lib.setPackage("waxe", "WaxeMe", "com.waxe.waxeme", "1.0");

      nme.AssetData.create();

      

      
      nme.display.Stage.setFixedOrientation( nme.display.Stage.OrientationLandscapeAny );
      
      
      #end
   

   
      #if flash
      flash.Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
      flash.Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;

      var load = function() ApplicationBoot.createInstance();

      
         new nme.preloader.Basic(800, 600, 16777215, load);
      


      #elseif waxe

      #if nme
      nme.display.ManagedStage.initSdlAudio();
      #end

      if (ApplicationBoot.canCallMain())
         ApplicationBoot.createInstance();
      else
      {
         wx.App.boot(function()
         {
            var size = { width: 800, height: 600 };
            
               frame = wx.Frame.create(null, null, "WaxeMe", null, size);
            


            #if nme
            wx.NMEStage.create(frame, null, null, { width: 800, height: 600 });
            #end

            ApplicationBoot.createInstance();

            if (autoShowFrame)
            {
               wx.App.setTopWindow(frame);
               frame.shown = true;
            }
         });
      }
      #else
      nme.Lib.create(function() { 
            nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
            nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
            nme.Lib.current.loaderInfo = nme.display.LoaderInfo.create (null);
            ApplicationBoot.createInstance();
         },
         800, 600, 
         24, 
         16777215,
         (true ? nme.Lib.HARDWARE : 0) |
         nme.Lib.ALLOW_SHADERS | nme.Lib.REQUIRE_SHADERS |
         (false ? nme.Lib.DEPTH_BUFFER : 0) |
         (false ? nme.Lib.STENCIL_BUFFER : 0) |
         (true ? nme.Lib.RESIZABLE : 0) |
         (false ? nme.Lib.BORDERLESS : 0) |
         (false ? nme.Lib.VSYNC : 0) |
         (false ? nme.Lib.FULLSCREEN : 0) |
         (0 == 4 ? nme.Lib.HW_AA_HIRES : 0) |
         (0 == 2 ? nme.Lib.HW_AA : 0),
         "WaxeMe"
         
      );
      #end
      
   }

   @:keep function keepMe() { Reflect.callMethod(null,null,null); }

   public static function setAndroidViewHaxeObject(inObj:Dynamic)
   {
      #if androidview
      try
      {
         var setHaxeObject = nme.JNI.createStaticMethod("null.nullBase",
              "setHaxeCallbackObject", "(Lorg/haxe/nme/HaxeObject;)V", true, true );
         if (setHaxeObject!=null)
            setHaxeObject([inObj]);
      }
      catch(e:Dynamic) {  }
      #end
   }

   public static function getAsset(inName:String) : Dynamic
   {
      var i = Assets.info.get(inName);
      if (i==null)
         throw "Asset does not exist: " + inName;
      var cached = i.getCache();
      if (cached!=null)
         return cached;
      switch(i.type)
      {
         case BINARY, TEXT: return Assets.getBytes(inName);
         case FONT: return Assets.getFont(inName);
         case IMAGE: return Assets.getBitmapData(inName);
         case MUSIC, SOUND: return Assets.getSound(inName);
      }

      throw "Unknown asset type: " + i.type;
      return null;
   }
   
   
   #if neko
   public static function __init__ () {
      
      untyped $loader.path = $array ("@executable_path/", $loader.path);
      
   }
   #end
   
   
}

