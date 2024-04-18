import { ComponentBuilderContext, RNAbility, RNInstance } from 'rnoh';
import { createRNPackages } from '../../RNPackagesFactory';

/**
 * RN 逻辑简单封装, 逻辑参考鸿蒙 SDK 的 RNApp.ets 类
 * 加载
 * 资源释放
 */
@Component
@Preview
export struct RNContainer {
  @State private shouldShow: boolean = false
  @StorageLink('RNAbility') rnAbility: RNAbility | undefined = undefined
  private rnInstance: RNInstance | undefined

  aboutToDisappear(): void {
     this.init()
  }

  aboutToAppear(): void {
    this.init()
  }

  async init() {
    this.aboutToDisappear()
    console.log(`hepan init`)
    if (!this.rnAbility) {
      return
    }
    try {
      // 创建 Instance, 
      let instance = await this.createRNInstance()
      console.log(`hepan insta = ${instance}`)
      if (instance) {
        this.rnInstance = instance
      }else{
      }

    } catch (error) {
    }

  }

  /**
   * 创建
   * @returns
   */
  createRNInstance(): Promise<RNInstance | void> {
    if (this.rnAbility) {
      return Promise.resolve()
    }
    return Promise.resolve()
    return this.rnAbility!.createAndRegisterRNInstance({ createRNPackages });

  }

  build() {
    Stack() {
      Text('wewer')

    }.width('100%')
    .height('100%')
  }
}