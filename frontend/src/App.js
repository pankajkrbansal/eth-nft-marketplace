import {Routes, Route} from 'react-router-dom'
import Marketplace from './components/Marketplace'
import NFTpage from './components/NFTpage'
import Profile from './components/Profile'
import SellNFT from './components/SellNFT'
import './App.css';
import Navigation from './components/Navigation'

function App() {
  return (
    <div className="App">
      <Navigation/>
      <Routes>
        <Route path="/" element={<Marketplace/>}/>
        <Route path="/nft/:tokenId" element={<NFTpage/>}/>
        <Route path="/profile" element={<Profile/>}/>
        <Route path="/sellnft" element={<SellNFT/>}/>
      </Routes>
    </div>
  );
}

export default App;
