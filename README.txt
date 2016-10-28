1. Download BOW.zip
2. Extract BOW.zip
3. Add below two lines at the top of your test.m:
	VLFEATROOT = './vlfeat-0.9.20/';
	run([VLFEATROOT, 'toolbox/vl_setup']);
   Note: This way, it will add 'VLFeat' to MATLAB environment. If this modification is not 	 done, then code will crash.

