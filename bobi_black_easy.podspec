

Pod::Spec.new do |s|


  s.name         = "bobi_black_easy"

  s.version      = "0.0.14"

  s.summary      = "iOS bobi_black_easy"

  s.description  = <<-DESC
  					能优化和严格的内存控制让其运行更加的流畅和稳健。
                   DESC

  s.homepage     = "https://github.com/Miles-Matheson"

  s.license      = "MIT"

  s.author       = { "John" => "liyida188@163.com" }

  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/Miles-Matheson/bobi.black.oc.easy.git", :tag => "0.0.14" }

  s.requires_arc = true

  s.default_subspec = "Core"

  s.subspec "Core" do |core|
    	core.source_files   = "bobi_black_easy/**/*.{h,m,mm,a,pch}"
    	core.resources      = "bobi_black_easy/Resources/*.{png,bundle}"  
	core.dependency 'Masonry'
  	core.dependency 'JJException'
  	core.dependency 'IQKeyboardManager'
  	core.dependency 'SVProgressHUD'
  	core.dependency 'YYWebImage'
  	core.dependency 'MBProgressHUD'
  	core.dependency 'CBImagePicker'

  end


end
