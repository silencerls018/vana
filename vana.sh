#!/bin/bash

# 一键脚本：数据流动池 (DLP) 创建菜单版

echo "欢迎使用数据流动池 (DLP) 一键脚本！"
echo "请选择要执行的步骤："
echo "1. 克隆 DLP ChatGPT 仓库"
echo "2. 创建 .env 文件"
echo "3. 安装依赖"
echo "4. 创建钱包"
echo "5. 添加 Satori Testnet 到 MetaMask"
echo "6. 导出私钥并导入 MetaMask"
echo "7. 生成加密密钥"
echo "8. 克隆 DLP 智能合约仓库"
echo "9. 部署 DLP 智能合约"
echo "10. 配置 DLP 合约"
echo "11. 运行 Validator 节点"
echo "0. 退出"
read -p "请输入选项： " OPTION

function prompt_continue() {
    read -p "是否继续？(y/n)： " choice
    if [[ "$choice" != "y" ]]; then
        echo "操作已取消。"
        exit 1
    fi
}

case $OPTION in
    1)
        echo "克隆 DLP ChatGPT 仓库..."
        git clone https://github.com/vana-com/vana-dlp-chatgpt.git
        cd vana-dlp-chatgpt || exit
        echo "克隆完成。"
        ;;
    2)
        echo "创建 .env 文件..."
        cp .env.example .env
        echo "请在 .env 文件中填写 DLP 相关信息。"
        ;;
    3)
        echo "安装依赖..."
        poetry install
        echo "依赖安装完成。"
        ;;
    4)
        echo "创建钱包..."
        vanacli wallet create --wallet.name default --wallet.hotkey default
        echo "钱包创建完成。请保存助记词。"
        ;;
    5)
        echo "请在 MetaMask 中添加 Satori Testnet 网络。"
        echo "网络名称: Satori Testnet"
        echo "RPC URL: https://rpc.satori.vana.org"
        echo "Chain ID: 14801"
        echo "货币: VANA"
        ;;
    6)
        echo "导出冷钱包私钥..."
        vanacli wallet export_private_key --wallet.name default --key_type coldkey
        echo "请将私钥导入 MetaMask。"
        echo "导出热钱包私钥..."
        vanacli wallet export_private_key --wallet.name default --key_type hotkey
        echo "请将热钱包私钥也导入 MetaMask。"
        ;;
    7)
        echo "生成加密密钥..."
        ./keygen.sh
        echo "密钥生成完成。"
        ;;
    8)
        echo "克隆 DLP 智能合约仓库..."
        cd .. || exit
        git clone https://github.com/vana-com/vana-dlp-smart-contracts.git
        cd vana-dlp-smart-contracts || exit
        echo "仓库克隆完成。"
        ;;
    9)
        echo "请在 .env 文件中填写私钥、地址等信息。"
        echo "部署 DLP 智能合约..."
        npx hardhat deploy --network satori --tags DLPDeploy
        echo "智能合约部署完成！"
        ;;
    10)
        echo "请访问 https://satori.vanascan.io/address/ 配置 DLP 合约。"
        echo "配置完成后，请更新 .env 文件中的 DLP 合约地址和加密密钥。"
        ;;
    11)
        echo "运行 Validator 节点..."
        poetry run python -m chatgpt.nodes.validator
        echo "Validator 节点正在运行，请监控日志确保运行正常。"
        ;;
    0)
        echo "退出脚本。"
        exit 0
        ;;
    *)
        echo "无效选项，请重新选择。"
        ;;
esac

echo "脚本执行完成。感谢使用！"
