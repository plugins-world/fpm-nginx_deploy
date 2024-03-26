#!/usr/bin/env bash

# 切换node版本(不一定需要)
# nvm use v16.19.0
# yarn global add cross-env

# 进入HBuild的cli目录，uni-app 打包相关命令都封装在cli里面了
CLI_DIR=/Applications/HBuilderX.app/Contents/HBuilderX/plugins/uniapp-cli/
cd $CLI_DIR

# 指定项目根地址
INIT_CWD=/path/to/project-name

# H5端开发模式运行(对应IDE上的运行到浏览器，会自动打开浏览器)
#cross-env UNI_INPUT_DIR=$INIT_CWD/ UNI_OUTPUT_DIR=$INIT_CWD/unpackage/dist/dev/h5 UNI_PLATFORM=h5 NODE_ENV=development node bin/uniapp-cli.js

# 开发模式打包app
#cross-env UNI_INPUT_DIR=$INIT_CWD/ UNI_OUTPUT_DIR=$INIT_CWD/unpackage/dist/dev/app-plus UNI_PLATFORM=app-plus NODE_ENV=development node bin/uniapp-cli.js

# 打包编译H5端(对应IDE上的发行网站)
cross-env UNI_INPUT_DIR=$INIT_CWD/ UNI_OUTPUT_DIR=$INIT_CWD/unpackage/dist/build/h5 UNI_PLATFORM=h5 NODE_ENV=production node bin/uniapp-cli.js

# 发行模式打包app(最终生成wgt)

# 先导出
#rm -rf INIT_CWD/unpackage/dist/build/app-plus
#cross-env UNI_INPUT_DIR=$INIT_CWD/ UNI_OUTPUT_DIR=$INIT_CWD/unpackage/dist/build/app-plus UNI_PLATFORM=app-plus NODE_ENV=production node bin/uniapp-cli.js

# 在zip压缩成wgt
#cd INIT_CWD/unpackage/dist/build/app-plus
#zip -q -r INIT_CWD/unpackage/release/app-plus.wgt ./
