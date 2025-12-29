import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_learning/core/constants/app_constants.dart';
import 'package:e_learning/presentation/bloc/home/home_bloc.dart';
import 'package:e_learning/presentation/widgets/course_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const LoadCoursesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(const RefreshCoursesEvent());
            },
            child: CustomScrollView(
              slivers: [
                // Header
                SliverAppBar(
                  floating: true,
                  backgroundColor: const Color(AppConstants.primaryColor),
                  elevation: 0,
                  expandedHeight: 140,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        color: Color(AppConstants.primaryColor),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Welcome back!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    BlocBuilder<HomeBloc, HomeState>(
                                      builder: (context, state) {
                                        if (state is HomeLoaded) {
                                          return Text(
                                            'Keep up your ${state.streak}-day streak 🔥',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.flash_on,
                                            color: Color(AppConstants.accentColor),
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          BlocBuilder<HomeBloc, HomeState>(
                                            builder: (context, state) {
                                              if (state is HomeLoaded) {
                                                return Text(
                                                  state.totalXp.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                );
                                              }
                                              return const Text(
                                                '0',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Content
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return SliverFillRemaining(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: const Color(AppConstants.primaryColor),
                            ),
                          ),
                        );
                      }

                      if (state is HomeLoaded) {
                        return SliverList(
                          delegate: SliverChildListDelegate([
                            const Text(
                              'Continue Learning',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...state.courses
                                .asMap()
                                .entries
                                .map((entry) {
                                  final course = entry.value;
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16),
                                    child: CourseCard(
                                      course: course,
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          '/course',
                                          arguments: course.id,
                                        );
                                      },
                                    ),
                                  );
                                })
                                .toList()
                                .cast<Widget>(),
                          ]),
                        );
                      }

                      return SliverFillRemaining(
                        child: Center(
                          child: Text(
                            'Something went wrong',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
