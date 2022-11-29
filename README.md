# ToyERC-X
The toy implementation of ERC-X.
## ERC-20: Fungible Token
- totalSupply(): 총 발행량 확인
- blanaceOf(address account): account의 잔고 확인
- transfer(address recipient, uint256 amout): recipient에게 자신의 토큰 전송
- approve(address spender, uint256 amount): spender에게 자신의 토큰 전송 권리 부여
- allowance(address owner, address spender): owner가 spender에게 부여한 토큰 양 확인
- transferFrom(address sender, address recipient, uint256 amount): sender에게 부여받은 토큰을 recipient 전송
## ERC-721: Non-fungible tokens
You can see my NFT [here](https://testnets.opensea.io/collection/zvehyeon)!
- mintNFT(address recipient, string tokenURI): tokenURI NFT를 recipient에게 mint
## ERC-1155: Mixed use of fungible and non-fungible tokens
To be implemented