// lib/screens/onboarding_candidate.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color kPrimaryIndigo = Color(0xFF3949AB); // main indigo
const Color kPrimaryIndigoDark = Color(0xFF1A237E);

class OnboardingCandidateScreen extends StatefulWidget {
  const OnboardingCandidateScreen({super.key});

  @override
  State<OnboardingCandidateScreen> createState() => _OnboardingCandidateScreenState();
}

class _OnboardingCandidateScreenState extends State<OnboardingCandidateScreen> {
  final PageController _pageController = PageController();
  int _page = 0;

  final List<_OnboardPage> pages = [
    _OnboardPage(
      title: 'Discover jobs that fit',
      subtitle: 'Search hundreds of verified opportunities and filter by location, salary, and job type.',
      icon: Icons.search_rounded,
    ),
    _OnboardPage(
      title: 'Apply in seconds',
      subtitle: 'Quickly apply using your profile and resume. Track application status in one place.',
      icon: Icons.send_rounded,
    ),
    _OnboardPage(
      title: 'Manage interviews & offers',
      subtitle: 'Receive interview invites, save offers, and accept the best fit — all inside the app.',
      icon: Icons.event_available_rounded,
    ),
  ];

  void _next() {
    if (_page < pages.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 420), curve: Curves.easeInOut);
    } else {
      _finish();
    }
  }

  void _skip() {
    _pageController.animateToPage(pages.length - 1, duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
  }

  void _finish() {
    // navigate to login or main flow
    Get.offAllNamed('/login'); // change this route if you want
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        children: [
          // small brand / left (optional)
          SizedBox(
            height: 40,
            child: Row(children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.badge_rounded, color: Colors.white)),
              const SizedBox(width: 8),
              const Text('Candidate', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
            ]),
          ),
          const Spacer(),
          TextButton(
            onPressed: _skip,
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            child: const Text('Skip'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryIndigo, kPrimaryIndigoDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (context, index) {
                    final p = pages[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: media.width * 0.07, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // big rounded illustration
                          Container(
                            height: media.height * 0.36,
                            width: media.height * 0.36,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [kPrimaryIndigo.withOpacity(0.95), kPrimaryIndigoDark.withOpacity(0.9)]),
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.22), blurRadius: 24, offset: const Offset(0, 10))],
                            ),
                            child: Center(
                              child: Icon(p.icon, size: media.height * 0.13, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            p.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            p.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white.withOpacity(0.92), fontSize: 15.0, height: 1.4),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // indicator + actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18),
                child: Column(
                  children: [
                    // animated dot indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(pages.length, (i) {
                        final active = i == _page;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: active ? 28 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active ? Colors.white : Colors.white54,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: active ? [BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 8, offset: const Offset(0, 4))] : null,
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Get.toNamed('/login'),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.08),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              side: BorderSide(color: Colors.white.withOpacity(0.12)),
                            ),
                            child: const Text('Sign in'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _next,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: kPrimaryIndigo,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 6,
                            ),
                            child: Text(_page == pages.length - 1 ? 'Get started' : 'Next', style: const TextStyle(fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardPage {
  final String title;
  final String subtitle;
  final IconData icon;
  const _OnboardPage({required this.title, required this.subtitle, required this.icon});
}