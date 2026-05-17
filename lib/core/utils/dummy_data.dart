import '../../data/model/news_model.dart';

class DummyData {
  static final List<Article> newsList = [
    Article(
      source: Source(name: "BBC Science"),
      author: "Dr. Sarah Jenkins",
      title:
          "NASA's Artemis Mission Discovers Unexpected Water Ice Deposits on Lunar South Pole",
      description:
          "In a groundbreaking discovery that could accelerate humanity's plans for a sustainable lunar base, NASA's latest orbital reconnaissance mission has identified massive deposits of water ice hidden within the permanently shadowed craters...",
      urlToImage:
          "https://images.unsplash.com/photo-1614730321146-b6fa6a46bcb4?q=80&w=1000&auto=format&fit=crop",
      publishedAt: "2026-05-17T10:00:00Z",
      content:
          "In a groundbreaking discovery that could accelerate humanity's plans for a sustainable lunar base, NASA's latest orbital reconnaissance mission has identified massive deposits of water ice hidden within the permanently shadowed craters of the Moon's South Pole.\n\nThe findings, published earlier today in the Planetary Science Journal, suggest that the volume of accessible ice is nearly double previous estimates. This crucial resource could theoretically provide life support for astronauts and be synthesized into rocket propellant for deep space missions to Mars and beyond.\n\nDr. Thomas Zurbuchen, former associate administrator for the Science Mission Directorate, noted that the distribution pattern of the ice suggests geological activity far more recent than previously understood. The data indicates that some of these deposits may have been formed by ancient volcanic outgassing, rather than solely by comet impacts over billions of years.\n\nThe Artemis III mission, currently slated for late 2026, aims to land the first astronauts in this precise region. Today's discovery will likely cause a shift in the planned landing coordinates to ensure the crew can drill and sample these newly identified high-density zones.\n\nContinue reading the full technical analysis on the BBC Science portal.",
    ),
    Article(
      source: Source(name: "Tech Crunch"),
      author: "Alex Rivera",
      title: "Next-Gen AI Chips Promise 10x Efficiency Boost for Data Centers",
      description:
          "New architecture promises to slash energy consumption for training large language models.",
      urlToImage:
          "https://images.unsplash.com/photo-1518770660439-4636190af475?q=80&w=1000&auto=format&fit=crop",
      publishedAt: "2026-05-17T09:30:00Z",
    ),
    Article(
      source: Source(name: "Sports Network"),
      author: "Chris Evans",
      title: "Global Championship Finals Scheduled for New Mega-Stadium",
      description:
          "The highly anticipated finals will take place in the newly completed 100,000 capacity venue.",
      urlToImage:
          "https://images.unsplash.com/photo-1519315901367-f34f92243d6a?q=80&w=1000&auto=format&fit=crop",
      publishedAt: "2026-05-17T08:15:00Z",
    ),
    Article(
      source: Source(name: "Finance Daily"),
      author: "Maria Santos",
      title: "Major Tech Merger Finalized, Reshaping Cloud Market Dynamics",
      description:
          "Two industry giants have completed their \$50B merger, creating a new leader in enterprise cloud services.",
      urlToImage:
          "https://images.unsplash.com/photo-1590283603385-17ffb3a7f29f?q=80&w=1000&auto=format&fit=crop",
      publishedAt: "2026-05-16T15:45:00Z",
    ),
    Article(
      source: Source(name: "Nature Journal"),
      author: "Dr. Chen Wei",
      title: "Breakthrough in Cellular Repair Mechanics Published in Nature",
      description:
          "Researchers have identified a new protein pathway that significantly accelerates cellular regeneration.",
      urlToImage:
          "https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?q=80&w=1000&auto=format&fit=crop",
      publishedAt: "2026-05-16T11:20:00Z",
    ),
  ];
}
