

Pod::Spec.new do |s|


  s.name         = "bobi_black_easy"

  s.version      = "0.0.29"

  s.summary      = "iOS bobi_black_easy"

  s.description  = <<-DESC
  					能优化和严格的内存控制让其运行更加的流畅和稳健。
                   DESC

  s.homepage     = "https://github.com/Miles-Matheson"

  s.license      = "MIT"

  s.author       = { "John" => "liyida188@163.com" }

  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/Miles-Matheson/bobi.black.oc.easy.git", :tag => "0.0.29" }

  s.requires_arc = true

  s.default_subspec = 'All'
  	s.subspec 'All' do |spec|
    	spec.dependency 'bobi_black_easy/Addocshugenbro'
  end

  s.subspec 'Addocshugenbro' do |spec|

    	spec.requires_arc = true
    	spec.resources      = 'bobi_black_easy/Assets/*.xcassets' 
	spec.source_files   = 'bobi_black_easy/Classes/Addocshugenbro/**/*.{h,m,mm,a,pch}'
	spec.dependency 'Masonry'
  	spec.dependency 'JJException'
  	spec.dependency 'IQKeyboardManager'
  	spec.dependency 'SVProgressHUD'
  	spec.dependency 'YYWebImage'
  	spec.dependency 'MBProgressHUD'
	spec.dependency 'ReactiveObjC'
  	spec.dependency 'CBImagePicker'

	spec.dependency 'TXIMSDK_Plus_iOS', '~> 5.6.1200'


	spec.dependency 'Toast'
	spec.dependency 'SDWebImage'
	spec.dependency 'YYText'
	spec.dependency 'YYWebImage'
	spec.dependency 'YYCache'
	spec.dependency 'TZImagePickerController'
	spec.dependency 'SDCycleScrollView'
	spec.dependency 'Reachability'
	spec.dependency 'MJRefresh'
	spec.dependency 'MJExtension'

	spec.dependency 'IAPHelper'
	spec.dependency 'FMDB'
	spec.dependency 'AFNetworking'
	spec.dependency 'YBImageBrowser'



  end


end
