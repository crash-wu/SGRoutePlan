# SouthgisTileLayer
Southgis TileLayer. It support "TianDitu Tile Layer","Baidu Tile Layer",and "WMT Layer."
# Requirements
* Xcode 6 or higher

* Apple LLVM compiler

* iOS 7.0 or higher

* ARC

* ArcGIS-Runtime-SDK-iOS V10.2.4 

#Usage
  ##1.Tianditu Tile Layer
  
      #import "SouthgisTianDiTuWMTSLayer.h"
      
     SouthgisTianDiTuWMTSLayer *layer=[[SouthgisTianDiTuWMTSLayer alloc]initWithLayerType:layerType layerURL:nil error:&err];
     
  ##2. Baidu Tile Layer 
  
    #import "SouthgisBdWMTSLayer.h"
    
      SouthgisBdWMTSLayer *layer=[[SouthgisBdWMTSLayer alloc]initWithLayerType:BDVecLayerType error:&err];

  ##3. WMTTile Layer
  
     #import "Southgis_TiledServiceLayer.h"
     
      Southgis_TiledServiceLayer *titl=[[Southgis_TiledServiceLayer alloc]initTiledServiceLayerURL:tileServiceURL];
         
# Installation
-----
##cocoapod


Install CocoaPods if not already available:
   
    $ [sudo] gem install cocoapods
    $ pod setup

Change to the directory of your Xcode project and edit PodFile:

    pod 'SouthgisTileLayer'

Install into your Xcode project:
  
     pod install or pod update
  
