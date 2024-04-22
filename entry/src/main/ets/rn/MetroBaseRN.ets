/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

import { MetroJSBundleProvider, RNAbility, RNInstance, RNSurface } from "rnoh";
import { createRNPackages } from '../RNPackagesFactory';

@Component
export struct MetroBaseRN {
  @StorageLink('RNAbility') rnAbility: RNAbility | undefined = undefined;
  private rnInstance!: RNInstance
  @State private shouldShow: boolean = false
  moduleName: string = 'snowbox';
  initProps: Record<string, string> = {};

  aboutToAppear() {
    this.init()
  }


  private async init() {
    if(!this.rnAbility){
      return

    }
    try {
      await (async () => {
        this.rnInstance =  await this.rnAbility!!.createAndRegisterRNInstance({ createRNPackages })
        const provider = new MetroJSBundleProvider()

        this.rnInstance.runJSBundle(provider)
        this.rnInstance.getBundleExecutionStatus(provider.getURL())
        this.shouldShow = true

      })()
    } catch (reason) {

    }
  }

  build() {
    Column() {
      if (this.rnAbility && this.shouldShow) {
        RNSurface({
          surfaceConfig: {
            initialProps: this.initProps ?? {},
            appKey: this.moduleName,
          },
          ctx: this.rnAbility.createRNOHContext({ rnInstance: this.rnInstance }),
        })
      }
    }
    .height('100%')
    .width('100%')
  }
}

