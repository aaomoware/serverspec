require 'spec_helper'

mesa_dri1_version = '7.11'
mesa_dri_version = '10.1.2'
tcl_version = '8.5.7'
libICE_version = '1.0.6'
libSM_version = '1.2.1'
libtool_ltdl_version = '2.2.6'
libX11_version = '1.6.0'
libX11_common_version = '1.6.0'
libXxf86vm_version = '1.1.3'
mesa_dri_filesystem_version = '10.1.2'
mesa_libGL_version = '10.1.2'
mesa_libGLU_version = '10.1.2'
mesa_private_llvm = '3.4'
tk_version = '8.5.7'
version_unixODBC = '2.2.14'
version_wxBase = '2.8.12'
version_wxGTK = '2.8.12'
version_wxGTK_gl = '2.8.12'

describe command("yum info mesa-dri1-drivers") do
	its(:stdout) { should match /Version     : #{mesa_dri1_version}/}
end

describe command("yum info mesa-dri-drivers") do
	its(:stdout) { should match /Version     : #{mesa_dri_version}/}
end

describe command("yum info tcl") do
	its(:stdout) { should match /Version     : #{tcl_version}/}
end

describe command("yum info libICE") do
	its(:stdout) { should match /Version     : #{libICE_version}/}
end

describe command("yum info libSM") do
	its(:stdout) { should match /Version     : #{libSM_version}/}
end

describe command("yum info libtool-ltdl") do
	its(:stdout) { should match /Version     : #{libtool_ltdl_version}/}
end

describe command("yum info libX11") do
	its(:stdout) { should match /Version     : #{libX11_version}/}
end

describe command("yum info libX11-common") do
	its(:stdout) { should match /Version     : #{libX11_common_version}/}
end

describe command("yum info libX11-common") do
	its(:stdout) { should match /Version     : #{libX11_common_version}/}
end

describe command("yum info libXxf86vm") do
	its(:stdout) { should match /Version     : #{libXxf86vm_version}/}
end

describe command("yum info mesa-dri-filesystem") do
	its(:stdout) { should match /Version     : #{mesa_dri_filesystem_version}/}
end

describe command("yum info mesa-libGL") do
	its(:stdout) { should match /Version     : #{mesa_libGL_version}/}
end

describe command("yum info mesa-libGLU") do
	its(:stdout) { should match /Version     : #{mesa_libGL_version}/}
end

describe command("yum info mesa-private-llvm") do
	its(:stdout) { should match /Version     : #{mesa_private_llvm}/}
end

describe command("yum info tk") do
	its(:stdout) { should match /Version     : #{tk_version}/}
end

describe command("yum info unixODBC") do
	its(:stdout) { should match /Version     : #{version_unixODBC}/}
end

describe command("yum info wxBase") do
	its(:stdout) { should match /Version     : #{version_wxBase}/}
end

describe command("yum info wxGTK") do
	its(:stdout) { should match /Version     : #{version_wxGTK}/}
end

describe command("yum info wxGTK-gl") do
	its(:stdout) { should match /Version     : #{version_wxGTK_gl}/}
end
