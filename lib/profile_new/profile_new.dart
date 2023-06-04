import 'package:faheem/cubit/profile_new/cubit/profile_new_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/widgets.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with TickerProviderStateMixin {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: ProfileNewAppBarWidget(),
      ),
      body: ProfileNewView(
        unfocusNode: _unfocusNode,
      ),
    );
  }
}

class ProfileNewView extends StatefulWidget {
  const ProfileNewView({
    super.key,
    required FocusNode unfocusNode,
  }) : _unfocusNode = unfocusNode;

  final FocusNode _unfocusNode;
  @override
  State<ProfileNewView> createState() => _ProfileNewViewState();
}

class _ProfileNewViewState extends State<ProfileNewView> {
  // @override
  // void initState() {
  //   super.initState();
  //   final email =
  //       FirebaseAuth.instance.currentUser?.email ?? "noEmail@noEmail.com";
  //   BlocProvider.of<ProfileNewCubit>(context).getProfileNewData(email);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileNewCubit, ProfileNewState>(
      builder: (context, profileNewState) {
        final profileNewCubit = BlocProvider.of<ProfileNewCubit>(context);
        if (profileNewState is ProfileNewStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (
            //   groupListState is GroupsListStateSuccess
            // &&
            profileNewState is ProfileNewStateSuccess) {
          return SafeArea(
            child: GestureDetector(
              onTap: () =>
                  FocusScope.of(context).requestFocus(widget._unfocusNode),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const UserInfoWidget(),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(30, 12, 30, 0),
                        child: SizedBox(
                          // width: MediaQuery.of(context).size.width - 32,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UserParticipationInfoWidget(
                                icon: Icons.group_outlined,
                                number: profileNewCubit.groupsDataModel.length,
                                text: 'المجموعة',
                              ),
                              UserParticipationInfoWidget(
                                icon: Icons.format_shapes,
                                number: profileNewCubit.testDataModel.length,
                                text: 'اختبار      ',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const MyTestsTextWidget(),
                      TestsListWidget(
                        groupList: profileNewCubit.groupsDataModel,
                        testsList: profileNewCubit.testDataModel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}


/* import 'package:faheem/cubit/profile_new/cubit/profile_new_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/widgets.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with TickerProviderStateMixin {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: ProfileNewAppBarWidget(),
      ),
      body: ProfileNewView(
        unfocusNode: _unfocusNode,
      ),
    );
  }
}

class ProfileNewView extends StatefulWidget {
  const ProfileNewView({
    super.key,
    required FocusNode unfocusNode,
  }) : _unfocusNode = unfocusNode;

  final FocusNode _unfocusNode;
  @override
  State<ProfileNewView> createState() => _ProfileNewViewState();
}

class _ProfileNewViewState extends State<ProfileNewView> {
  @override
  void initState() {
    super.initState();
    final email =
        FirebaseAuth.instance.currentUser?.email ?? "noEmail@noEmail.com";
    BlocProvider.of<ProfileNewCubit>(context).getProfileNewData(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileNewCubit, ProfileNewState>(
      builder: (context, profileNewState) {
        final profileNewCubit = BlocProvider.of<ProfileNewCubit>(context);
        if (profileNewState is ProfileNewStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (
            //   groupListState is GroupsListStateSuccess
            // &&
            profileNewState is ProfileNewStateSuccess) {
          return SafeArea(
            child: GestureDetector(
              onTap: () =>
                  FocusScope.of(context).requestFocus(widget._unfocusNode),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const UserInfoWidget(),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                        child: SizedBox(
                          // width: MediaQuery.of(context).size.width - 32,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UserParticipationInfoWidget(
                                icon: Icons.group_outlined,
                                number: profileNewCubit.groupsDataModel.length,
                                text: 'المجموعة',
                              ),
                              UserParticipationInfoWidget(
                                icon: Icons.format_shapes,
                                number: profileNewCubit.testDataModel.length,
                                text: 'اختبار',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const MyTestsTextWidget(),
                      TestsListWidget(
                        groupList: profileNewCubit.groupsDataModel,
                        testsList: profileNewCubit.testDataModel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
 */